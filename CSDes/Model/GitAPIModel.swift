//
//  GitAPIModel.swift
//  CSDes
//
//  Created by c136582 on 05/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

import Foundation
import UIKit

struct GitApiGeneralModel: Codable {
    let total_count: Int?
    let incomplete_results: Bool?
    let items: [GitApiItemsModel]?
}

struct GitApiItemsModel: Codable {
    let name: String?
    let full_name: String?
    let description: String?
    let owner: OwnerModel?
    let stargazers_count: Int?
    let forks_count: Int?
 //   let image: Data
}

struct OwnerModel: Codable {
    let login: String?
    let avatar_url: String?
}


/*
 
 {
 "total_count": 3969071,
 "incomplete_results": false,
 “items”: []
 }

 */
