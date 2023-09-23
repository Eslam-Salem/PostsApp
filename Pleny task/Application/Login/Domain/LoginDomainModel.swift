//
//  LoginDomainModel.swift
//  Pleny task
//
//  Created by Eslam Salem on 23/09/2023.
//

import Foundation

struct LoginDomainModel {
    var id: Int?
    var username: String?
    var token: String?
    
    init(loginAPIModel: LoginAPIModel) {
        self.id = loginAPIModel.id
        self.username = loginAPIModel.username
        self.token = loginAPIModel.token
    }
}
