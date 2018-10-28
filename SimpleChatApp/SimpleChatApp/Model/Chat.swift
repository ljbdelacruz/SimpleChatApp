//
//  Chat.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 28/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import CoreData
import Firebase

class Chat:NSManagedObject{
    
    
    func set(ia:Bool, message:String, sender:String){
        self.isArchived=ia;
        self.message=message;
        self.sender=sender;
    }
    static func all(rname:String, context:NSManagedObjectContext, completionHandler: @escaping (Chat?, Error?) -> ()){
        let db=Database.database().reference().child("Inbox").child(rname);
        FirebaseCustom.RetrieveDataValue(db: db, completionHandler: {
            (ds) in
            let dict=ds!.value as! Dictionary<String, Any>;
            completionHandler(Chat.setup(dict: dict, context: context), nil);
        })
    }
    static func setup(dict:[String:Any], context:NSManagedObjectContext)->Chat{
        var temp=Chat(context: context);
        temp.set(ia: (dict["isArchived"] as! Int) == 0 ? false:true, message: dict["message"] as! String, sender: dict["sender"] as! String);
        return temp;
    }
    
}
