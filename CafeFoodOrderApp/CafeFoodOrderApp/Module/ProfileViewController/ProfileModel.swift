//
//  ProfileModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//

import Foundation

// MARK: - Welcome
struct DataProfileModel: Codable {
    let status: Int
    let message: String
    let data: DataProfileUser
}

// MARK: - DataClass
struct DataProfileUser: Codable {
    let userID, username, email, phoneNumber: String
    let profileImageURL: String
    let fullName, dateOfBirth, gender: String
    let address: Address
}

// MARK: - Address
struct Address: Codable {
    let street, city, state, zipCode: String
    let country: String
}

