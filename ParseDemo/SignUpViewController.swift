//
//  SignUpViewController.swift
//  ParseDemo
//
//  Created by Rumiya Murtazina on 7/30/15.
//  Copyright (c) 2015 abearablecode. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var usernameField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func btnSignUp(sender: AnyObject) {
        var email = self.emailField.text!
        var username = self.usernameField.text!
        var password = self.passwordField.text!
        
        //finalemail true
        var finalemail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        
        //check xem nhap user va pass dung khong
        if username.characters.count < 5 {
            var thongbao = UIAlertView(title: "Error", message: "Please enter username > 5 character", delegate: self, cancelButtonTitle: "OK")
            thongbao.show()
        }else
            if password.characters.count < 5{
            var thongbao = UIAlertView(title: "Error", message: "Please enter password > 5 character", delegate: self, cancelButtonTitle: "OK")
            thongbao.show()
        }else
                if email.characters.count < 8 {
                    var thongbao = UIAlertView(title: "Error", message: "Please enter email > 5 character", delegate: self, cancelButtonTitle: "OK")
                    thongbao.show()
        }else
                {
                    //create snipper
                    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
                    spinner.startAnimating()
                    
                    var newUser = PFUser()
                    
                    newUser.username = username
                    newUser.password = password
                    newUser.email = finalemail
                    
                    
                    // Sign up the user asynchronously
                    newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                        
                        // Stop the spinner
                        spinner.stopAnimating()
                        if ((error) != nil) {
                            var thongbao = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                            thongbao.show()
                            
                        } else {
                            var thongbao = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                            thongbao.show()
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! UIViewController
                                self.presentViewController(viewController, animated: true, completion: nil)
                            })
                        }
                    })
        
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
