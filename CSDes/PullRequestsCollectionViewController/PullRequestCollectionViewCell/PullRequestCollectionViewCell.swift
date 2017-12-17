//
//  CollectionViewCell.swift
//  CSDes
//
//  Created by c136582 on 06/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

import UIKit

class PullRequestCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pullRequestTitle: UILabel!    
    @IBOutlet weak var pullRequestBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension PullRequestCollectionViewCell {
   
    func pullRequestData(owner: String, name: String) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/repos/\(owner)/\(name)/pulls"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        print("url: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.dataTask(with: request) { [unowned self] (data, response, error) in
            guard let jsonData = data else {return}
            let decoder = JSONDecoder()
            print("jsonData: \(jsonData)")
            do {
                let pullRequestReturn = try decoder.decode([PullRequestModel].self, from: jsonData)
                DispatchQueue.main.async {
                    print("pullRequestReturn.first?.title: \(pullRequestReturn.first?.title)")
                    print("pullRequestReturn.first?.body: \(pullRequestReturn.first?.body)")

                    self.pullRequestTitle.text = pullRequestReturn.first?.title
                    self.pullRequestBody.text = pullRequestReturn.first?.body
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
}
