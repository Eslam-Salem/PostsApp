//
//  PostModel.swift
//  Pleny task
//
//  Created by Eslam Salem on 21/09/2023.
//

import Foundation

struct PostsAPIModel: Decodable {
    var posts: [PostAPIModel]?
    var message: String?
    var total: Int
}

struct PostAPIModel: Decodable {
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    var tags: [String]?
    var reactions: Int?
}
