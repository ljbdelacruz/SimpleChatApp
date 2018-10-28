//
//  SignupViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 25/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import SVProgressHUD;



class SignupViewController: UIViewController {

    @IBOutlet weak var UIEmail: UITextField!
    @IBOutlet weak var UIPassword: UITextField!
    @IBOutlet weak var UIRepassword: UITextField!
    var userInput:UserInfo=UserInfo();
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SubmitOnClick(_ sender: Any){
        SVProgressHUD.show();
        if self.UIPassword.text == self.UIRepassword.text!{
            self.userInput.set(email: self.UIEmail.text!, pass: self.UIPassword.text!, name:"");
            self.userInput.NewUser(completionHandler: {
                (res, err) in
                if err == nil{
                    print("Success Adding new user");
                }else{
                    print(err?.localizedDescription);
                }
                SVProgressHUD.dismiss();
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signupToDashboard" {
            let destVC=segue.destination as! DashboardViewController;
            destVC.userInfo=self.userInput;
        }
    }
}

extension SignupViewController{
    
}

