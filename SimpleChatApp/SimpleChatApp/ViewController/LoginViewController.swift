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
        self.UIEmailTF.delegate=self;
        self.UIPasswordTF.delegate=self;
        self.TFSetup();
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
            if error != nil {
                print("Success Auth")
            }else{
                print(error?.localizedDescription);
            }
            SVProgressHUD.dismiss()
        })
    }
}

extension LoginViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.3, moveDistance: 100, up: false)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as! AdjustingTF).Move(view: self.view, duration: 0.3, moveDistance: 0, up: false)
    }
}


//MARK: -TF Setup
extension LoginViewController{
    func TFSetup(){
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        navBar.barStyle = UIBarStyle.blackTranslucent;
        navBar.backgroundColor = UIColor.black;
        navBar.alpha = 0.9;
        //replace viewWidth with view controller width
        let navItem = UINavigationItem()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
            ,target: self, action: #selector(CloseKeyboard))
        navItem.rightBarButtonItem = doneButton
        navBar.pushItem(navItem, animated: false)
        self.UIEmailTF.inputAccessoryView=navBar;
        self.UIPasswordTF.inputAccessoryView=navBar;
    }
    @objc func CloseKeyboard(){
        self.view.endEditing(true)
    }
}

