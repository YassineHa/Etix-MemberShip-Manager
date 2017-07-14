//
//  UserViewModel.swift
//  EUM
//
//  Created by Yassine-Ha on 14/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

// the User View model for the MVVM patern
class UserViewModel: NSObject {

    var user : User = User(anId: 0, aName: "")
    
    override init() {
        super.init()
    }
    
    init(aUser: User) {
        user = aUser
    }
    
    var nameText : String? {
        return user.name
    }
    
    var userId : Int? {
        return user.id
    }
}
