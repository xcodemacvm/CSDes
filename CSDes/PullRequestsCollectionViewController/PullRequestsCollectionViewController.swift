//
//  PullRequestsCollectionViewController.swift
//  CSDes
//
//  Created by c136582 on 06/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cellId"

protocol PullRequestsCollectionViewPresenter {
    weak var pullRequestsCollectionViewController: PullRequestsCollectionViewController? {get set}
    
    var repositoryOwner: String? {get set}
    var repositoryName: String? {get set}
}

class PullRequestsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presenter: PullRequestsCollectionViewPresenter?
    
    
    init(pullRequestsCollectionViewPresenter: PullRequestsCollectionViewPresenter) {
  //      super.init(nibName: "PullRequestsCollectionViewController", bundle: nil)
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.presenter = pullRequestsCollectionViewPresenter
        self.presenter?.pullRequestsCollectionViewController = self
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
     tableView.register(UINib(nibName: "nibFileName", bundle: nil), forCellReuseIdentifier: "cellIdentifer")
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CollectionView Here!")
        collectionView?.backgroundColor = .white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
 //       self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView?.register(UINib(nibName: "PullRequestCollectionViewCell", bundle: nil).self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PullRequestCollectionViewCell
       // cell.pullRequestData(owner: "ReactiveX", name: "RxJava")
        if let owner = presenter?.repositoryOwner, let name = presenter?.repositoryName {
            cell.pullRequestData(owner: owner, name: name)
            print("owner: \(owner) name: \(name)")
        }
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(5)
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
}
