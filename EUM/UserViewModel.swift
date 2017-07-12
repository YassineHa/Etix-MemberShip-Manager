//
//  UserViewModel.swift
//  EUM
//
//  Created by Yassine-Ha on 12/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

class UserViewModel: NSObject {

    @IBOutlet var client : Client!
    
    // the list of all the available users of a specific Organization  to display
    var users = [User]()
    
    //fetching all the  Organizations by completion (function wrapped up into a parameter)
    func fetchAvailableUsers(completion : @escaping () ->()) {
        client.fetchAndAddUsers {
            users in self.users = users ?? [User]()
            completion()
        }
    }
    
    //return the number of users item
    func numberOfItemsInSection(section: Int) -> Int {
        return users.count
    }
    
    // fill the shared selected User
    func fillSharedSelectedUser(indexPath : IndexPath){
        Shared.sharedInstance.selectedUser = users[indexPath.row]
    }
    
    //return the user name per indexPath
    func titleForItemAtIndexPath(indexPath : IndexPath) -> String {
        return users[indexPath.row].name
    }
}
