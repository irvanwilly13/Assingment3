//
//  RegisterModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import Foundation

struct RegistParam: Codable {
    let username: String
    let password: String
    let confirmPassword: String
}

struct RegistResponse: Codable {
    let status, message: String
    let data: RegistData
}

// MARK: - DataClass
struct RegistData: Codable {
    let user: UserDataRegist
    let token: String
}


// MARK: - User
struct UserDataRegist: Codable {
    let id: Int
    let username: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "username"
        case createdAt = "created_at"
    }
}
