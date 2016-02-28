//
//  ViewController.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/15/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking
import BDBOAuth1Manager


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //objects are instantiated within classes. Objects are used to implement properties or methods
    //Singleton is an object that is created to be used in the entire project; identified by sharedInstance
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                // perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
                
            } else {
                //handle login error
            }
        }
           
    }

}