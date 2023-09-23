//
//  PostDomainModel.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation

struct PostsDomainModel {
    var posts: [PostDomainModel]?
    var message: String?
    var total: Int
    
    init(postsApiModel: PostsAPIModel) {
        self.posts = postsApiModel.posts?.map { PostDomainModel(postApiModel: $0) }
        self.message = postsApiModel.message
        self.total = postsApiModel.total
    }
}

struct PostDomainModel: Identifiable {
    var id: String = UUID().uuidString // This property uniquely identifies each post because post id value isn't unique its repeated in another pages
    var title: String?
    var body: String?
    var reactions: Int?

    init(postApiModel: PostAPIModel) {
        self.title = postApiModel.title
        self.body = postApiModel.body
        self.reactions = postApiModel.reactions
    }
}
