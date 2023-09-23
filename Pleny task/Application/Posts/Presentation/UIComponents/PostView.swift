//
//  PostView.swift
//  Pleny task
//
//  Created by Eslam Salem on 22/09/2023.
//

import SwiftUI

struct PostView: View {
  var post: PostDomainModel
  
  var body: some View {
    VStack(alignment: .leading) {
      // Display the post author's profile picture (replace with your image view)
      HStack(alignment: .center) {
        Image("profile")
          .resizable()
          .frame(width: 40, height: 40)
          .foregroundColor(.blue) // Customize as needed
        
        // Display the user's name and post data
        VStack(alignment: .leading, spacing: 4) {
          Text("Eslam salem") // Replace with the actual user name property
            .font(.body)
            .foregroundColor(.black)
          
          Text("2 Days ago") // Replace with the actual post data property
            .font(.footnote)
            .foregroundColor(.gray)
        }
        .padding(8)
      }
      .lineSpacing(8)
      
      // Display the post text
      Text(post.title ?? "")
        .font(.headline)
      
      // Display the post body
      Text(post.body ?? "")
        .font(.body)
      
      // Display the post image
      Image("post-image")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
      
      // Display the number of reactions (replace with your count view)
      HStack {
        Image(systemName: "heart.fill")
        Text("\(post.reactions ?? 0)") // Replace with the actual property
      }
    }
  }
}

struct PostView_Previews: PreviewProvider {
  static var previews: some View {
    PostView(post: PostDomainModel(postApiModel: PostAPIModel()))
  }
}
