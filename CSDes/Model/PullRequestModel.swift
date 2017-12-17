//
//  PullRequestModel.swift
//  CSDes
//
//  Created by xcodedev on 12/12/2017.
//  Copyright © 2017 c136582. All rights reserved.
//

import Foundation
import UIKit

struct PullRequestModel: Decodable {
    let title: String
    let body: String?
    let user: UserModel

    enum CodingKeys: String, CodingKey {
        case title
        case body
        case user
    }
}

struct UserModel: Decodable {
    let username: String
    let avatarURL: String
    let userDetailsURL: String
    
    enum CodingKeys: String, CodingKey {
        case username = "login"
        case avatarURL = "avatar_url"
        case userDetailsURL = "url"
    }
}

struct UserDetailsModel: Decodable {
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
    }
}
