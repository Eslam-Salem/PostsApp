//
//  ServerGalleryRepo.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation
import Combine

class ServerGalleryRepo: GalleryApiRepository {
    private var cancellables: Set<AnyCancellable> = []

    func getPosts(page: Int, completion: @escaping (_ : PostsDomainModel?, _ : String?) -> Void) {
        ApiManager.shared.getPosts(page: page)
            .sink(receiveCompletion: { [weak self] receiveCompletion in
                self?.handleReceiveCompletion(receiveCompletion: receiveCompletion, completion: completion)
            }, receiveValue: { [weak self] response in
                self?.handleGettingResponse(response: response, completion: completion)
            })
            .store(in: &cancellables)
    }
    
    func searchPosts(page: Int, query: String, completion: @escaping (PostsDomainModel?, String?) -> Void) {
        ApiManager.shared.getSearchedPosts(page: page, searchQuery: query)
            .sink(receiveCompletion: { [weak self] receiveCompletion in
                self?.handleReceiveCompletion(receiveCompletion: receiveCompletion, completion: completion)
            }, receiveValue: { [weak self] response in
                self?.handleGettingResponse(response: response, completion: completion)
            })
            .store(in: &cancellables)
    }
    
    func handleGettingResponse(response: PostsAPIModel, completion: @escaping (_ : PostsDomainModel?, _ : String?) -> Void) {
        if let errorMessage = response.message  {
            // Failed
            print(errorMessage)
            completion(nil, errorMessage)
        } else {
            // Successful
            print(response)
            completion(PostsDomainModel(postsApiModel: response), nil)
        }
    }
    
    func handleReceiveCompletion(receiveCompletion: Subscribers.Completion<NetworkError>, completion: @escaping (_ : PostsDomainModel?, _ : String?) -> Void) {
        switch receiveCompletion {
        case .finished:
            break
        case .failure(let error):
            print(error)
            completion(nil, error.localizedDescription)
        }
    }
}
