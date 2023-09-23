//
//  ApiManager.swift
//  Pleny task
//
//  Created by Eslam Salem on 20/09/2023.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get
    case post
}

class ApiManager {
    static let shared = ApiManager()

    func login(username: String, password: String) -> AnyPublisher<LoginAPIModel, NetworkError> {
        let body: [String: String] = [
            "username": username,
            "password": password
        ]
        return NetworkLayer.callApi(with: "/auth/login", httpMethod: .post, body: body)
            .eraseToAnyPublisher()
    }
    
    func getPosts(page: Int) -> AnyPublisher<PostsAPIModel, NetworkError> {
        let params = [
            "skip": "\(page)",
            "limit": "15"
        ]
        return NetworkLayer.callApi(with: "/posts", httpMethod: .get, params: params)
            .eraseToAnyPublisher()
    }
    
    func getSearchedPosts(page: Int, searchQuery: String) -> AnyPublisher<PostsAPIModel, NetworkError> {
        let params = [
            "q": searchQuery,
            "skip": "\(page)",
            "limit": "15"
        ]
        return NetworkLayer.callApi(with: "/posts/search", httpMethod: .get, params: params)
            .eraseToAnyPublisher()
    }
}
