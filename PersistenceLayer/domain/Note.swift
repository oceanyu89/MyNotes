//
//  Note.swift
//  MyNotes
//
//Created by ocean.yu on 16/4/01.

//

import Foundation

class Note {
//Swift1.1 -> Swift1.2修改点 start
    var ID:String?//NSString改为String
    var date:String?//NSString改为String
    var content:String?//NSString改为String
    
    init(id:String?, date:String?, content:String?) {//NSString改为String
        self.ID = id
        self.date = date
        self.content = content
    }
}
//Swift1.1 -> Swift1.2修改点 end