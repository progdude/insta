//
//  LoginViewController.swift
//  instagram
//
//  Created by Archit Rathi on 2/21/16.
//  Copyright © 2016 Archit Rathi. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passWord: UITextField!;
    @IBOutlet weak var userName: UITextField!;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    @IBAction func signIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userName.text!, password: passWord.text!){
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil{
                print("logged in");
                self.performSegueWithIdentifier("loginSegue", sender: nil);
            }
        }
        
    }

    @IBAction func signUp(sender: AnyObject) {
        print(passWord.text);
        let newUser = PFUser()
        if (userName.text?.isEmpty == false) {
            newUser.username = userName.text
            if (passWord.text?.isEmpty == false) {
                newUser.password = passWord.text
                newUser.signUpInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if success {
                        print("Yay, created a user!");
                        self.performSegueWithIdentifier("loginSegue", sender: nil);
                    } else {
                        print(error?.localizedDescription);
                        if(error?.code==202){
                            print("user is taken");
                        }
                    }
                    
                    
                })
            }
        }
    }
}
