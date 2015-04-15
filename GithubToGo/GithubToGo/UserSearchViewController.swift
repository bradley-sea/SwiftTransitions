//
//  UserSearchViewController.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class UserSearchViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate, UINavigationControllerDelegate {
  var users = [User]()
  var imageFetchService = ImageFetchService()
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.collectionView.dataSource = self
      self.searchBar.delegate = self
      //self.navigationController?.delegate = self

        // Do any additional setup after loading the view.
    }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    GithubService.sharedInstance.fetchUsersForSearchTerm(searchBar.text, callback: { (users, error) -> (Void) in
      self.users = users!
      self.collectionView.reloadData()
    })
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.delegate = nil
  }

  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.users.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("USER_CELL", forIndexPath: indexPath) as! UserCell
    cell.imageView.image = nil
    var user = self.users[indexPath.row]
    if user.avatarImage == nil {
     self.imageFetchService.fetchAvatarImageForURL(user.avatarURL, completionHandler: { (image) -> (Void) in
      cell.imageView.alpha = 0
      cell.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
        cell.imageView.image = image
        user.avatarImage = image
        self.users[indexPath.row] = user
      UIView.animateWithDuration(0.3, animations: { () -> Void in
        cell.imageView.alpha = 1
        cell.imageView.transform = CGAffineTransformMakeScale(1.0, 1.0)

      })
      })
    } else {
      cell.imageView.image = user.avatarImage
    }
    return cell
  }
  
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if toVC is UserDetailViewController {
      //return the animation controller
      return ToUserDetailAnimationController()
    }
    return nil
  }
  

  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "SHOW_USER_DETAIL" {
      let destinationVC = segue.destinationViewController as! UserDetailViewController
      let selectedIndexPath = self.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      destinationVC.selectedUser = self.users[selectedIndexPath.row]
      
    }
  }


}
