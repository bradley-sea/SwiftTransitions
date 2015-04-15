//
//  User.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import UIKit

struct User {
  let name : String
  let avatarURL : String
  let url : String
  var avatarImage : UIImage?
  
  init (name : String, avatarURL : String, url : String) {
    self.name = name
    self.avatarURL = avatarURL
    self.url = url
  }
}
