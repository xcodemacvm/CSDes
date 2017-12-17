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

class NetworkController {
    
    static private var avatarImages: [UIImage]? = [UIImage]()
    static private var repositories: [GitApiItemsModel]? = [GitApiItemsModel]()

    init(collectionViewToReload: UICollectionView) {
        NetworkController.mapJSONToModel(collectionViewToReload: collectionViewToReload)
    }
    
    static var getAvatarImages: [UIImage]? {
        get {
            guard let avatarImages = NetworkController.avatarImages else {return nil}
            
            return avatarImages
        }
    }

    static var getRepositories: [GitApiItemsModel]? {
        get {
            guard let repositories = NetworkController.repositories else {return nil}
            
            return repositories
        }
    }

    // Mapeia o JSON para um GitApiModel
    private static func mapJSONToModel(collectionViewToReload: UICollectionView) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        let q = URLQueryItem(name: "q", value: "language:Java")
        let sort = URLQueryItem(name: "sort", value: "stars")
        let page = URLQueryItem(name: "page", value: "1")
        urlComponents.queryItems = [q, sort, page]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        print("url: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let jsonData = data else {return}
            //     print("data: \(jsonData)")
            let decoder = JSONDecoder()
            
            do {
                
                let gitResult = try decoder.decode(GitApiGeneralModel.self, from: jsonData)
                    repositories = gitResult.items
                    print("repositories.count: \(String(describing: repositories?.count))")
            //        collectionViewToReload.reloadData()
                NetworkController.mapImages(from: NetworkController.repositories, collectionViewToReload: collectionViewToReload)

                print("Oi!")

                
                //      completion?(.success(posts))
            } catch {
                print("deu erro cara!")
            }
            
        }
        task.resume()
        print("Opaaaaaaaaaaaa")
    }
    
    private static func mapImages(from gitItems: [GitApiItemsModel]?, collectionViewToReload: UICollectionView ) {
        guard let gitItems = gitItems else {return}
        avatarImages = [UIImage](repeatElement(UIImage(), count: gitItems.count))
        print("gitItems.count: \(gitItems.count)")
        var indexOrder: [Int]? = [Int]()
        let queue = DispatchQueue(label: "MyQueue")
        for (index, _) in gitItems.enumerated() {
            print("dentro do mapImages")

            guard let urlImage = URL(string: (gitItems[index].owner?.avatar_url!)!) else {return}
                          //      print("urlImage: \(urlImage)")
            var request = URLRequest(url: urlImage)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            request.httpMethod = "GET"
        //    print("request : \(request)")
            //                    self.avatarImages = [UIImage]()
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                //    print("data: \(data)")
                
                
                if let data = data {
                    
                        guard let image = UIImage(data: data) else {return}
                        // image = nil
                  //      NetworkController.avatarImages?.append(image)
                        //NetworkController.avatarImages?.append(UIImage())
                    NetworkController.avatarImages?.remove(at: index)
                    NetworkController.avatarImages?.insert(image, at: index)

                    queue.sync {
                        indexOrder?.append(index)
                        print("indexOrder: \(indexOrder)")
                    }
                    
                    print("avatarImages.count no append: \(avatarImages?.count)")
                        collectionViewToReload.reloadData()
                        print("deu reload no \(String(describing: avatarImages?.count))")
                    
                    print("avatarImages aqui: \(NetworkController.avatarImages?.count ?? 0)")
                }
            }).resume()
        }
        print("Antes aqui")
    }
}

