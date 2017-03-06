//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Thuan Nguyen on 2/21/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let twitterClient = TwitterClient.sharedInstance
        twitterClient?.login(success: {
            print("logged in")
            self.performSegue(withIdentifier: "loginSeque", sender: nil)
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        
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
