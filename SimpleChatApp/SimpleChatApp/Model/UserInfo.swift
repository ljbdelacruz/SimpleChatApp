//
//  UserInfo.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 25/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Firebase;


class UserInfo{
    var Email:String=""
    var Password:String="";
    var Name:String="";
    convenience init(email:String, pass:String, name:String){
        self.init()
        self.set(email: email, pass: pass, name:name);
    }
    func set(email:String, pass:String, name:String){
        self.Email=email;
        self.Password=pass;
    }
    func NewUser(completionHandler: @escaping (Any?, Error?) -> ()){
        FirebaseCustom.createUser(email: self.Email, password: self.Password, completionHandler: {
            (res, err) in
            print(res);
            completionHandler(err == nil ? res : nil, err != nil ? err : nil)
        })
    }
    static func NewUserInfo(email:String, name:String, completionHandler: @escaping (Any?, Error?) -> ()){
        let db=Database.database().reference().child("UserInfo").child(email);
        let param=["email":email, "name":name];
        FirebaseCustom.InsertData(data: param, db: db, completionHandler: completionHandler)
    }
    
    static func GetByEmail(email:String, completionHandler: @escaping (Any?, Error?) -> ()){
        let db=Database.database().reference().child("UserInfo").child(email);
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            let data=UserInfo.setup(response: ds!);
            completionHandler(data, nil);
        })
    }
    
    static func setup(response:DataSnapshot)->UserInfo{
        let dict=response.value as! Dictionary<String, Any>;
        let temp=UserInfo();
        temp.set(email: dict["email"] as! String, pass: "", name: dict["name"] as! String);
        return temp;
    }
    
    
    
    
    
    
}
