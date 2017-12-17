//
//  RepositoryCell.swift
//  CSDes
//
//  Created by c136582 on 07/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

import UIKit

class RepositoryCell: UICollectionViewCell {

    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    
    @IBOutlet weak var forksCount: UILabel!
    @IBOutlet weak var starsCount: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullName: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 //       avatarImage.layer.cornerRadius = avatarImage.bounds.width/2
 //       avatarImage.layer.backgroundColor = UIColor.red.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        if let avatarImage = avatarImage {

            avatarImage.layer.cornerRadius = 25
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension RepositoryCell {
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
}
