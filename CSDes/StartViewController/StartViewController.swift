//
//  ViewController.swift
//  CSDes
//
//  Created by c136582 on 05/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

/*
 
 func firstTask(completion: (success: Bool) -> Void) {
 // Do something
 
 // Call completion, when finished, success or faliure
 completion(success: true)
 }
 And use your completion block like this:
 
 firstTask { (success) -> Void in
 if success {
 // do second task if success
 secondTask()
 }
 }
 
 */

import UIKit

protocol StartViewPresenter {
    weak var startViewController: StartViewController? {get set}
    
    func didClickButton(owner: String?, name: String?)
    func pushPullRequestsViewController(owner: String?, name: String?)
    
}

private let reuseIdentifier = "cellId"

class StartViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

//    @IBAction func clickButton(_ sender: UIButton) {
//        presenter?.didClickButton()
//    }
    
    var presenter: StartViewPresenter?
    private var repositories: [GitApiItemsModel]? = [GitApiItemsModel]()
    private var avatarImages: [UIImage]? = [UIImage]()
    private var numberOfPages: Int = 1
    private let pageSize: Int = 5
    
    init(startViewPresenter: StartViewPresenter) {
        super.init(nibName: "StartViewController", bundle: nil)
        presenter = startViewPresenter
        presenter?.startViewController = self
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
      //  networkRequest()
        collectionView?.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        setupCollectionView()
    }

    func setupCollectionView() {
        if let collectionView = collectionView {
            
            NetworkController.mapJSONToModel(url: URL.getRepositoriesURL(), completion: { (networkResult) in
                switch networkResult {
                case .success(let repositories):
                    self.repositories = repositories
                    DispatchQueue.main.async {
                        collectionView.reloadData()
                    }
                case .failure(let error):
                    print("erro: \(error.localizedDescription)")
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var maxPages = 0
        if let repositories = repositories {
            if repositories.count % pageSize == 0 {
                maxPages = repositories.count / pageSize
            } else {
                maxPages = repositories.count / pageSize + 1
            }
            
            guard numberOfPages <= maxPages else {return maxPages*pageSize}
            return pageSize*numberOfPages
        }
        
        
        return 0
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (collectionView?.contentOffset.y)! + UIScreen.main.bounds.height == collectionView?.contentSize.height {
            numberOfPages += 1
            collectionView?.reloadData()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RepositoryCell
    //    repositories = NetworkController.getRepositories
        
        print("count: ABC")
        if let repositories = repositories {
            cell.repositoryName.text = repositories[indexPath.row].name
            cell.repositoryDescription.text = repositories[indexPath.row].description
            cell.starsCount.text = String(describing: repositories[indexPath.row].stargazers_count!)
            cell.forksCount.text = String(describing: repositories[indexPath.row].forks_count!)
            cell.username.text = repositories[indexPath.row].name
            cell.fullName.text = repositories[indexPath.row].full_name
            cell.avatarImage.layer.cornerRadius = cell.avatarImage.bounds.width / 2
            cell.avatarImage.clipsToBounds = true
            cell.getAvatarImage(imageURLString: (repositories[indexPath.row].owner?.avatar_url)!)
            
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.1).cgColor
        print("SELECTED!")
        
        if let repositories = repositories {
            let repo = repositories[indexPath.row].name
            let owner = repositories[indexPath.row].owner?.login
            presenter?.didClickButton(owner: owner, name: repo)
        }
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.backgroundColor = UIColor.yellow.cgColor
        
        print("DESELECTED!!!")
    }

}

