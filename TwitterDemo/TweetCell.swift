//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/26/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class  {
    func profileImageViewTapped(cell: TweetCell, user: User)
}
class TweetCell: UITableViewCell {

    @IBOutlet weak var retweetImage: UIButton!
    @IBOutlet weak var likeImage: UIButton!
    @IBOutlet weak var retweetCount: UILabel!

    @IBOutlet weak var cellView: UIView! {
        didSet {
            self.cellView.isUserInteractionEnabled = true
                let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
                self.cellView.addGestureRecognizer(userProfileTap)
        }
    }
    
    
    
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet{
            self.avatarImage.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.avatarImage.addGestureRecognizer(userProfileTap)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    weak var delegate: TweetTableViewCellDelegate!
    var tweet: Tweet!
    var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage.layer.cornerRadius = 5
        avatarImage.clipsToBounds
            = true
    }
    func userProfileTapped(_ gesture: UITapGestureRecognizer){
        if let delegate = delegate{
            delegate.profileImageViewTapped(cell: self, user: self.tweet.user!)
        }
        
    }
    
    @IBAction func retweeted(_ sender: Any) {
        self.retweetImage.setImage(UIImage(named: "retweet-icon-green"), for: [])
        
        let id = tweet.id_str
        TwitterClient.sharedInstance?.retweet(id: id, success: { (tweetReturn: Tweet) in
            print("Tweet: \(tweetReturn.text!)")
            self.tweet.retweetCount = self.tweet.retweetCount+1
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    
    @IBAction func liked(_ sender: Any) {
        self.likeImage.setImage(UIImage(named: "favor-icon-red"), for: [])
        let id = tweet.id_str
        TwitterClient.sharedInstance?.likeTweet(id: id, success: { (Tweet) in
            
            self.tweet.favoritesCount = self.tweet.favoritesCount+1
            self.tableView.reloadData()
        }, failure: {(error: Error) in
            print("Error: \(error.localizedDescription)")
        })
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
