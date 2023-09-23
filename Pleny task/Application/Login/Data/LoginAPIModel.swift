//
//  LoginModel.swift
//  Pleny task
//
//  Created by Eslam Salem on 20/09/2023.
//

import Foundation

struct LoginAPIModel: Decodable {
    var id: Int?
    var username: String?
    var email: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var image: String?
    var token: String?
    var message: String?
}
