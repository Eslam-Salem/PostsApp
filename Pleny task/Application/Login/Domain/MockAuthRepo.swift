//
//  MockAuthRepo.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation

class MockAuthRepository: AuthRepository {
    var successRespone: LoginDomainModel?
    var failedResponse: String?
    
    func login(userName: String, password: String, completion: @escaping (LoginDomainModel?, String?) -> Void) {
        if let successRespone = successRespone {
            completion(successRespone, nil)
        } else if let failedResponse = failedResponse {
            completion(nil, failedResponse)
        }
    }
}
