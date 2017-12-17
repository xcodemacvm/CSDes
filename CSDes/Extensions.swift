//
//  Extensions.swift
//  CSDes
//
//  Created by c136582 on 06/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

import Foundation

extension URL {
    
    static func getRepositoriesURL() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        let q = URLQueryItem(name: "q", value: "language:Java")
        let sort = URLQueryItem(name: "sort", value: "stars")
        let page = URLQueryItem(name: "page", value: "1")
        urlComponents.queryItems = [q, sort, page]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        return url
    }
    
    static func getPullRequestsURL(owner: String, name: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/repos/\(owner)/\(name)/pulls"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        return url
    }
    
    //    func getRepositoryAvatarImageURL() -> URL {
    //
    //    }
    
    
//    func getPullRequestAvatarImage() -> URL {
//
//    }
    
}
