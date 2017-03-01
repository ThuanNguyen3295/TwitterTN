//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/28/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var dateJoinedLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sreenNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = User.currentUser {
        userNameLabel.text = user.name
        sreenNameLabel.text = "@\(user.screenName!)"
        dateJoinedLabel.text = user.joinedDate
        userAvatarImage.setImageWith(user.profileURL as! URL)
        tweetLabel.text = String(describing: user.tweetCount!)
        likeLabel.text = String(describing: user.likeCount!)
        followingLabel.text = String(describing: user.followingCount!)
        followersLabel.text = String(describing: user.followersCount!)
            
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
