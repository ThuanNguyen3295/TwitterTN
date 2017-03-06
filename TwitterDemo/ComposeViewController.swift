//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 3/2/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var screenName: UILabel!
    var window: UIWindow?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.endEditing(false)
        tweetTextView.becomeFirstResponder()
        if let currentUser = User.currentUser {
            name.text = currentUser.name
      screenName.text = "@\(currentUser.screenName!)"
      avatarImage.setImageWith(User.currentUser?.profileURL as! URL)
        }
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelCompose(_ sender: Any) {
        self.dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tweetStatus(_ sender: Any) {
        var status = tweetTextView.text!
        status = status.replacingOccurrences(of: "Status:", with: "")
       TwitterClient.sharedInstance?.tweetStatus(status: status, success: {
        self.dismissKeyboard()
        self.dismiss(animated: true, completion: nil)

        
            }, failure: { (error: Error) in
        print(error.localizedDescription)
            })
    }
    func dismissKeyboard(){
        view.endEditing(true)
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
