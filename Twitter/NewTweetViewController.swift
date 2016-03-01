//
//  NewTweetViewController.swift
//  Twitter
//
//  Created by Abby  Bassie on 2/28/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBAction func sendBtn(sender: AnyObject) {
        print("hey")
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    var inReplyToUser: User?
    var delegate: TweetDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetTextView.delegate = self
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        tweetTextView.text = ""
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
