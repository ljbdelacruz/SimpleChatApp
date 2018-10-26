//
//  ChatRoom.swift
//  SimpleChatApp
//
//  Created by Lainel John Dela Cruz on 27/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import CoreData

class ChatRoom:NSManagedObject{
    func set(id:String, name:String, isFav:Bool, moderator:String){
        self.id=id;
        self.name=name;
        self.isFavorite=isFav;
        self.moderator=moderator;
    }
    
}
