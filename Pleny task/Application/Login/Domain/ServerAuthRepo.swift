//
//  ServerAuthRepo.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation
import Combine

class ServerAuthRepo: AuthRepository {
    private var cancellables: Set<AnyCancellable> = []

    func login(userName: String, password: String, completion: @escaping (_ :LoginDomainModel?, _ :String?) -> Void) {
        ApiManager.shared.login(username: userName, password: password)
            .sink(receiveCompletion: { receiveCompletion in
                switch receiveCompletion {
                case .finished:
                    break
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                }
            }, receiveValue: { response in
                if let errorMessage = response.message  {
                    // Failed
                    print(errorMessage)
                    completion(nil, errorMessage)
                } else {
                    // Successful
                    print(response)
                    completion(LoginDomainModel(loginAPIModel: response), nil)
                }
            })
            .store(in: &cancellables)
    }
}
