//
//  AuthenticationRepository.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation

protocol AuthRepository {
    func login(userName: String, password: String, completion: @escaping (_ :LoginDomainModel?, _ :String?) -> Void)
}
