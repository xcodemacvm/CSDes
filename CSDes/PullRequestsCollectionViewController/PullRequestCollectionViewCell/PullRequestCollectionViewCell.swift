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
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

extension PullRequestCollectionViewCell {
    func getAvatarImage(imageURLString: String) {
        NetworkController.mapImage(imageURLString: imageURLString) { (networkResult) in
            switch networkResult {
            case .success(let image):
                DispatchQueue.main.async {
                    self.avatarImage.image = image
                }
            case .failure(let error):
                print("erro: \(error.localizedDescription)")
            }
        }
    }
    
    func getFullName(urlString: String) {
        guard let url = URL(string: urlString) else {return}
        NetworkController.mapJSONToUserDetailsModel(url: url) { (networkResult) in
            switch networkResult {
                case .success(let fullName):
                    DispatchQueue.main.async {
                        self.fullName.text = fullName
                    }
                case .failure(let error):
                    print("erro: \(error.localizedDescription)")
            }

        }
    }
}

