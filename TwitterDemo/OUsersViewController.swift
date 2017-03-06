//
//  OUsersViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 3/1/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class OUsersViewController: UIViewController {
    var user: User?
    var cell: TweetCell?
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var backgroundView: UIImageView!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var likedCount: UILabel!

    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var likesCount: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = user {
        navigationItem.title = user.name
        screenNameLabel.text = user.screenName
        nameLabel.text = user.name
            
        avatarImage.setImageWith(user.profileURL as! URL)
        backgroundView.setImageWith(user.backgroundImageURL as! URL)
        followersCount.text =  String(describing: user.followersCount!)
        retweetCount.text = cell?.retweetCount.text
        likedCount.text = cell?.likeLabel.text
        tweetsCount.text = String(describing: user.tweetCount!)
            
        followingCount.text = String(describing: user.followingCount!)
        likesCount.text = String(describing: user.likeCount!)
        
        
        tweetLabel.text = cell?.tweetLabel.text
    }
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
