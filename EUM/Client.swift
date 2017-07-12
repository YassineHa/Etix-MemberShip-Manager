//
//  Client.swift
//  EUM
//
//  Created by Yassine-Ha on 12/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Client: NSObject {
    var myResponse : JSON = nil
    
    // parsing and fetching all the organizations from The DB
    func fetchAndAddOrganisations(completion : @escaping ([Organization]?) -> ()) {
        var organizations = [Organization]()
        
        // simple Get request for displaying
        Alamofire.request(Shared.sharedInstance.organizationsUrl!).responseJSON { (response) in
            
            switch response.result{
                
            // in case of request success
            case.success(let data):
                self.myResponse = JSON(data)
                
                // filling the organizations array
                for item in self.myResponse.arrayValue {
                    let organisation = Organization(id: item["id"].intValue, name: item["name"].stringValue)
                    organizations.append(organisation)
                }
                completion(organizations)
                
            // in case of request failure (404,..)
            case.failure(let error):
                print("request failed with ",error)
                completion(nil)
            }
        }
    }
    
  
    // parsing and fetching all the available Users ( by looping the subtract the shared list of users by selected Organization from all the users)
    func fetchAndAddUsers(completion : @escaping ([User]?) -> ()) {
        var users = [User]()
        
        // simple alamofire Get request
        Alamofire.request((Shared.sharedInstance.usersUrl)!).responseJSON { (response) in
            
            switch response.result{
                
            // in case of request success
            case.success(let data):
                self.myResponse = JSON(data)
                
                //looping all the users
                for item in self.myResponse.arrayValue {
                    // fetching the userItem into its model
                    let user = User(id: item["id"].intValue, name: item["name"].stringValue)
                    
                    //checking if the current list of users by selected organization  contains the user item (by comparing the ids)
                    if(!(Shared.sharedInstance.usersByOrganization.contains(where: { $0.id == user.id }))){
                        users.append(user)
                    }
                }
                completion(users)
                
            // in case of request failure
            case.failure(let error):
                print("request failed with ",error)
                completion(nil)
            }
        }
    }
    
    
}
