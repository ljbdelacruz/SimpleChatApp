//
//  ChatRoom.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 27/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class ChatRoom:NSManagedObject{
    func set(id:String, name:String, isFav:Bool, moderator:String){
        self.id=id;
        self.name=name;
        self.isFavorite=isFav;
        self.moderator=moderator;
    }
    
    static func all(context:NSManagedObjectContext, completionHandler: @escaping (ChatRoom?, Error?) -> ()){
        let db=Database.database().reference().child("Inbox");
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            var temp=ChatRoom.Setup(key: ds!.key, context: context)
            completionHandler(temp, nil);
//            completionHandler(ChatRoom.Setup(key:ds!.key, context:context), nil)
        })
    }
    static func likeName(name:String){
        let db=Database.database().reference().child("Inbox").queryEqual(toValue: name)
        FirebaseCustom.RetrieveDataValue(db: db as! DatabaseReference, completionHandler: {
            (ds) in
            print("Search result");
            print(ds);
            })
    }
    static func Setup(key:String, context:NSManagedObjectContext)->ChatRoom{
        let temp=ChatRoom(context:context);
        temp.set(id: key, name: key, isFav: false, moderator: "");
        return temp;
    }
    static func insert(rname:String, sender:String, message:String, completionHandler: @escaping (Any?, Error?) -> ()){
        let db=Database.database().reference().child("Inbox").child(rname);
        let param=["isArchive":false, "sender":sender, "message":message] as [String : Any];
        FirebaseCustom.InsertData(data: param, db: db, completionHandler: {
            (res, err) in
            err == nil ? completionHandler(res, nil) : completionHandler(nil, err);
        })
    }
    
    
}
