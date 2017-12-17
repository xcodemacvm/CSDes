//
//  NetworkController.swift
//  CSDes
//
//  Created by c136582 on 08/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//
// https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1

import Foundation
import UIKit

enum NetworkResult<T> {
    case success(T)
    case failure(Error)
}

enum ModelType {
    case gitRepository
    case pullRequests
}

class NetworkController {

    // Mapeia o JSON para um GitApiModel
    static func mapJSONToModel(url: URL?, completion: @escaping (NetworkResult<[GitApiItemsModel]>) -> Void) {
        
        guard let url = url else {return}

        print("url: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
            
            do {
                
                let gitResult = try decoder.decode(GitApiGeneralModel.self, from: jsonData)
                if let repositories = gitResult.items {
                    completion(.success(repositories))
                }
            } catch {
                    completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    static func mapJSONToUserDetailsModel(url: URL?, completion: @escaping (NetworkResult<String>) -> Void) {
        
        guard let url = url else {return}
        
        print("url: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
            
            do {
                
                let userDetails = try decoder.decode(UserDetailsModel.self, from: jsonData)
                if let fullName = userDetails.fullName {
                    completion(.success(fullName))
                }
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    static func mapImage(imageURLString: String, completion: @escaping (NetworkResult<UIImage>) -> Void) {

            guard let imageURL = URL(string: imageURLString) else {return}
            var request = URLRequest(url: imageURL)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            request.httpMethod = "GET"

        session.dataTask(with: request, completionHandler: { (data, response, error) in

                if let data = data {
                    guard let image = UIImage(data: data) else {return}
                    completion(.success(image))
                }
            }).resume()
    }
    
    
    static func pullRequestData(url: URL?, completionHandler: @escaping (NetworkResult<[PullRequestModel]>) -> Void) {
        
        guard let url = url else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
            print("jsonData: \(jsonData)")
            do {
                let pullRequestReturn = try decoder.decode([PullRequestModel].self, from: jsonData)
                DispatchQueue.main.async {
                    completionHandler(.success(pullRequestReturn))
                }
            } catch {
                    completionHandler(.failure(error))
            }
            }.resume()
    }
    
}

