//
//  PullRequestModel.swift
//  CSDes
//
//  Created by xcodedev on 12/12/2017.
//  Copyright © 2017 c136582. All rights reserved.
//

import Foundation
import UIKit

struct PullRequestModel: Codable {
    let title: String
    let body: String?
    let user: UserModel
}

struct UserModel: Codable {
    let login: String
    let avatar_url: String
    let url: String
}
