//
//  ImageFetchService.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

class ImageFetchService {

  let imageQueue = NSOperationQueue()

func fetchAvatarImageForURL(url : String, completionHandler : (UIImage) -> (Void)) {
  
  let url = NSURL(string: url)
  
  self.imageQueue.addOperationWithBlock { () -> Void in
    let imageData = NSData(contentsOfURL: url!)
    let image = UIImage(data: imageData!)
    
    NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
      completionHandler(image!)
    })
  }
}

}