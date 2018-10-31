//
//  TFAccessoryViewController.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 27/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class TFAccessoryViewController: UIViewController, UITextFieldDelegate {
    var navbarAccessory:UINavigationBar?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TFSetup();
    }
    func TFSetup(){
        self.navbarAccessory = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        navbarAccessory!.barStyle = UIBarStyle.blackTranslucent;
        navbarAccessory!.backgroundColor = UIColor.cyan;
        navbarAccessory!.alpha = 0.9;
        //replace viewWidth with view controller width
        let navItem = UINavigationItem()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done
            ,target: self, action: #selector(CloseKeyboard))
        doneButton.tintColor=UIColor.white
        navItem.rightBarButtonItem = doneButton
        navbarAccessory!.pushItem(navItem, animated: false)
    }
    
    @objc func CloseKeyboard(){
        self.view.endEditing(true)
    }
}
