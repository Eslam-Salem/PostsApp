//
//  PostsView.swift
//  Pleny task
//
//  Created by Eslam Salem on 21/09/2023.
//

import SwiftUI

struct PostsView: View {
  @ObservedObject var viewModel: PostViewModel
  @State private var searchText = ""
  
  var body: some View {
    NavigationView {
      List {
        SearchBarView(text: $searchText, placeholder: "Search Posts", onSearch: search)
        if viewModel.isFetching {
          ProgressView("Fetching Posts...")
        } else {
          ForEach(viewModel.displayedPosts, id: \.id) { post in
            PostView(post: post)
              .onAppear {
                if shouldLoadNextPage(for: post) {
                  callNextPage()
                }
              }
          }
        }
      }
      .navigationBarTitle("Posts")
      .listStyle(PlainListStyle())
    }
    .onAppear {
      viewModel.fetchPosts(.initalCall)
    }
    // Add a conditional bottom view
    if viewModel.isFetchingNextPage {
      ProgressView("Loading more...")
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary.colorInvert())
    }
  }
  
  private func callNextPage() {
    if searchText.isEmpty {
      viewModel.fetchPosts(.pagination)
    } else {
      viewModel.search(context: .pagination, query: searchText)
    }
  }
  
  private func search() {
    viewModel.search(context: .initalCall, query: searchText)
  }
  
  private func shouldLoadNextPage(for post: PostDomainModel) -> Bool {
    // Determine when to load the next page based on the last visible post
    guard let lastPost = viewModel.displayedPosts.last,
          viewModel.displayedPosts.count < viewModel.totalPostsNumber
    else {
      return false
    }
    return post.id == lastPost.id
  }
}

struct PostsView_Previews: PreviewProvider {
  static var previews: some View {
    PostsView(viewModel: PostViewModel(repository: ServerGalleryRepo()))
  }
}
