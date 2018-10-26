//
//  LoginViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 25/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var UIEmailTF: UITextField!
    @IBOutlet weak var UIPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print(FirebaseCustom.CreateID(db: DatabaseReference))
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func LoginOnClick(_ sender: Any) {
        SVProgressHUD.show();
        FirebaseCustom.AuthUser(email: self.UIEmailTF.text!, password: UIPasswordTF.text!, completionHandler: {
            (res, error) in
            if error != nil {
                print("Success Auth")
            }else{
                print(error?.localizedDescription);
            }
            SVProgressHUD.dismiss()
        })
    }
    
}
