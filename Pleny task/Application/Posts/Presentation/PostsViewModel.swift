//
//  PostsViewModel.swift
//  Pleny task
//
//  Created by Eslam Salem on 21/09/2023.
//

import Foundation
import Combine

class PostViewModel: ObservableObject {
    enum FetchPostContext {
        case initalCall
        case pagination
    }
    @Published var displayedPosts: [PostDomainModel] = []
    @Published var isFetching = false // Control the visibility of the activity indicator
    @Published var isFetchingNextPage = false // Control the visibility of the activity indicator for pagination
    @Published var currentPage = 0
    var totalPostsNumber = 0
    private var cancellables: Set<AnyCancellable> = []
    private var repository: GalleryApiRepository
    
    init(repository: GalleryApiRepository) {
        self.repository = repository
    }
    
    func fetchPosts(_ context: FetchPostContext) {
        handleFetchRequestContext(context)
        repository.getPosts(page: currentPage) { postsDomainModel, errorMsg in
            if let errorMsg = errorMsg {
                print(errorMsg) // to be handled by showing alert or bottom view.
            } else if let postsDomainModel = postsDomainModel  {
                self.displayedPosts.append(contentsOf: postsDomainModel.posts ?? [])
                self.totalPostsNumber = postsDomainModel.total
            }
            self.isFetching = false
            self.isFetchingNextPage = false
        }
    }
    
    private func handleFetchRequestContext(_ context: FetchPostContext) {
        switch context {
        case .pagination:
            currentPage += 1
            isFetchingNextPage = true
        case .initalCall:
            currentPage = 0
            displayedPosts.removeAll()
            isFetching = true
        }
    }
    
    func search(context: FetchPostContext, query: String) {
        currentPage = 0
        if query.isEmpty {
            fetchPosts(context)
        } else {
            fetchSearchedPosts(context, query: query)
        }
    }
    
    private func fetchSearchedPosts(_ context: FetchPostContext, query: String) {
        handleFetchRequestContext(context)
        repository.searchPosts(page: currentPage, query: query) { postsDomainModel, errorMsg in
            if let errorMsg = errorMsg {
                print(errorMsg) // to be handled by showing alert or bottom view.
            } else if let postsDomainModel = postsDomainModel  {
                self.displayedPosts.append(contentsOf: postsDomainModel.posts ?? [])
                self.totalPostsNumber = postsDomainModel.total
            }
            self.isFetching = false
            self.isFetchingNextPage = false
        }
    }
}
