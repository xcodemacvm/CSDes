//
//  StartViewPresenterImpl.swift
//  CSDes
//
//  Created by c136582 on 05/12/17.
//  Copyright © 2017 c136582. All rights reserved.
//

import Foundation

class StartViewPresenterImpl: StartViewPresenter {
    
    
    
    weak var startViewController: StartViewController?
    
    func didClickButton(owner: String?, name: String?) {
        print("Hello")
        pushPullRequestsViewController(owner: owner, name: name)
    }
    
    func pushPullRequestsViewController(owner: String?, name: String?) {
        let pullRequestsViewController = PullRequestsCollectionViewController(pullRequestsCollectionViewPresenter: PullRequestsCollectionViewPresenterImpl())
        
        pullRequestsViewController.presenter?.repositoryName = name
        pullRequestsViewController.presenter?.repositoryOwner = owner
        
        startViewController?.navigationController?.pushViewController(pullRequestsViewController, animated: true)
        print("to aquui")

    }
    
    
}
