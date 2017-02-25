//
//  TweetViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/25/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            for tweet in tweets {
             print(tweet.text ?? "")
            }
            //tableviee.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
