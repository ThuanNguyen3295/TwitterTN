//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/21/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: Date
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int ) ?? 0
        retweetCount = (dictionary["favourites_count"] as? Int ) ?? 0
        let timestampString = dictionary["created_at"] as? String
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString!)!
        
        
    }
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets =  [Tweet]()
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    

}
