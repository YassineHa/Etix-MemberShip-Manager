//
//  Shared.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import Foundation


// Shared is a Singleton struct that provides multiple variables for sharing instances
struct Shared {

    // static sharedInstance to keep track of  the instances created
    static var sharedInstance = Shared()
   
    // the current selected User to add
    var selectedUser = User(anId: 0, aName: "")
    
    // the current selected Organization to display its members
    var selectedOrganization = Organization(anId: 0, aName: "")
    
    // the list of users that are members of the selected organization
    var usersByOrganization = [User]()
    
    let baseUrl = URL(string: "http://localhost:3000/db")                       // url of the Json Db
    let usersUrl = URL(string: "http://localhost:3000/users")                   // url of the Json Users
    let membershipsUrl = URL(string: "http://localhost:3000/memberships")       // url of the Json MemberShips
    let organizationsUrl = URL(string: "http://localhost:3000/organizations")   // url of the Json Organizations
}
