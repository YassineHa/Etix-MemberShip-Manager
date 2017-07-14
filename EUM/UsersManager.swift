//
//  UserViewModel.swift
//  EUM
//
//  Created by Yassine-Ha on 12/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

// Users manager which manages the list of users
class UsersManager: NSObject {

    @IBOutlet var client : Client!
    
    // the list of all the available users of a specific Organization to display
    var users = [User]()

    
    // fetching all the available users to add for a specific Organization by completion (function wrapped up into a parameter)
    func fetchAvailableUsers(completion : @escaping () ->()) {
        client.fetchAndAddUsers {
            users in self.users = users ?? [User]()
            completion()
        }
    }
    
    // fetching all the users for a specific Organization by completion (function wrapped up into a parameter)
    func fetchAndAddUsersByOrganisation(completion : @escaping () ->()) {
        client.fetchAndAddUsersByOrganisation {
            users in self.users = users ?? [User]()
            completion()
        }
    }

    
    
    // return the number of users item
    func numberOfItemsInSection(section: Int) -> Int {
        return users.count
    }
    
    // fill the shared selected User
    func fillSharedSelectedUser(indexPath : IndexPath){
        Shared.sharedInstance.selectedUser = users[indexPath.row]
    }
    
   // fill the shared list of Users
    func fillSharedlistOfUsers(){
        // update the Shared instace of the list of users by removing the user
        Shared.sharedInstance.usersByOrganization = users
    }
    
    // return the user per indexPath
    func userForItemAtIndexPath(indexPath : IndexPath) -> User {
        return users[indexPath.row]
    }
    
    // remove a user per indexPath
    func removeItemAtIndexPath(indexPath : IndexPath) {
        users.remove(at: indexPath.row)
    }
    
    
    
}
