//
//  User.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/21/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenName: NSString?
    var profileURL: NSURL?
    var tagline: NSString?
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String as NSString?
        screenName = dictionary["screeen_name"] as? String as NSString?
        tagline = dictionary["description"] as? NSString
        let profileURLString = dictionary["profile_image_ulr_https"] as? NSString
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString as String)
        }
        
    }
    
    
    

}
