//
//  LoginViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 25/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: TFAccessoryViewController {

    @IBOutlet weak var UIEmailTF: UITextField!
    @IBOutlet weak var UIPasswordTF: UITextField!
    var userInfo:UserInfo?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        print(FirebaseCustom.CreateID(db: DatabaseReference))
        self.navigationController?.navigationBar.barTintColor=UIColor.red
        self.UIEmailTF.delegate=self;
        self.UIPasswordTF.delegate=self;
        self.UIEmailTF.inputAccessoryView=self.navbarAccessory;
        self.UIPasswordTF.inputAccessoryView=self.navbarAccessory;
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        self.UIEmailTF.delegate=self;
        self.UIPasswordTF.delegate=self;
    }
    @IBAction func LoginOnClick(_ sender: Any) {
        SVProgressHUD.show();
        FirebaseCustom.AuthUser(email: self.UIEmailTF.text!, password: UIPasswordTF.text!, completionHandler: {
            (res, error) in
            if error == nil {
                self.userInfo=UserInfo();
                self.userInfo!.set(email: self.UIEmailTF.text!, pass: "", name: "");
                self.performSegue(withIdentifier: "loginToDashboard", sender: nil);
            }else{
                print(error?.localizedDescription);
            }
            SVProgressHUD.dismiss()
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToDashboard" {
            let destVC=segue.destination as! DashboardViewController;
            destVC.userInfo=self.userInfo;
        }
    }
    
}
//MARK: -TextFieldFunctionalities
extension LoginViewController{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.3, moveDistance: 100, up: false)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.3, moveDistance: 0, up: false)
    }
}

