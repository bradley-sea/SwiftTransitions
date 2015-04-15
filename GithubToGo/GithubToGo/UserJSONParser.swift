//
//  UserJSONParser.swift
//  GithubToGo
//
//  Created by Bradley Johnson on 4/15/15.
//  Copyright (c) 2015 BPJ. All rights reserved.
//

import Foundation


class UserJSONParser {
  
  
  class func usersFromJSONData(data : NSData) -> [User] {
    
    var users = [User]()
    if let
      rootDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? [String : AnyObject],
      items = rootDictionary["items"] as? [[String : AnyObject]] {
        
        for userDictionary in items {
          if let
            login = userDictionary["login"] as? String,
            avatarURL = userDictionary["avatar_url"] as? String,
            url = userDictionary["url"] as? String {
              
              let user = User(name: login, avatarURL: avatarURL, url: url)
              users.append(user)
          }
        }
    }
    return users
  }
}