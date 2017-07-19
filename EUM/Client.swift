//
//  Client.swift
//  EUM
//
//  Created by Yassine-Ha on 12/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//


import Alamofire
import SwiftyJSON

// client for all the networking and parsing functions
class Client: NSObject {
    
    // the JSON response which contains all the parsed data
    var myResponse = JSON.null
    
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
                    let organisation = Organization(anId: item["id"].intValue, aName: item["name"].stringValue)
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
    
  
    // parsing and fetching all the available Users ( by looping all the users and subtract the shared list of users by selected Organization from all the users)
    func fetchAndAddAvailableUsers(completion : @escaping ([User]?) -> ()) {
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
                    let user = User(anId: item["id"].intValue, aName: item["name"].stringValue)
                    
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
    
    // adding a membership by passing its attributes( user_id, organization_id )
    func addMembership(user_id: Int, organization_id: Int) {
        
        // the new MemberShip  to post and add in the json DB
        let newMembership = ["user_id": user_id, "organization_id": organization_id ]
        
        // simple Post request
        Alamofire.request(Shared.sharedInstance.membershipsUrl!, method: .post, parameters: newMembership, encoding: JSONEncoding.default)
            .responseJSON { response in
                debugPrint(response)
                
        }
    }

    
    // parsing and fetching all the organization Users ( by looping the memberships and fetching the users list)
    func fetchAndAddUsersByOrganisation(completion : @escaping ([User]?) -> ()) {
        
        var usersByOrganisation = [User]()
        
        // simple alamofire get request
        Alamofire.request(Shared.sharedInstance.baseUrl!).responseJSON { (response) in
            switch response.result{
                
            // in case of request success
            case.success(let data):
                self.myResponse = JSON(data)
                
                // looping the memberships
                for MembershipItem in self.myResponse["memberships"].arrayValue {
                    
                    // checking if the organization id in the membership item is equal to the selected organization
                    if(MembershipItem["organization_id"].intValue == Shared.sharedInstance.selectedOrganization.id){
                   
                        // looping the users
                        for UserItem in self.myResponse["users"].arrayValue {
                            
                            // checking if the user id in the membership item is equal to the current user
                            if(MembershipItem["user_id"].intValue == UserItem["id"].intValue ){
                                let user = User(anId: UserItem["id"].intValue, aName: UserItem["name"].stringValue)
                                usersByOrganisation.append(user)
                                Shared.sharedInstance.usersByOrganization.append(user)
                            }
                        }
                    }
                }
                completion(usersByOrganisation)
                
            case.failure(let error):
                print("request failed with ",error)
                completion(nil)
            }
        }
    }
    
    // delete a membership by its id
    func DeleteMemberShip(deletedMembershipId: Int) {
       
        // the Url of the jsonObject to remove
        let deleteUrl = URL(string: "http://localhost:3000/memberships/\(deletedMembershipId)")
        
        // simple delete alamofire Request
        Alamofire.request(deleteUrl!, method: .delete)
            .responseJSON { response in
                if let error = response.result.error {
                    print(error)
                }
        }
    }
 
    //searching a membership by user and organization id and returning its id
    func searchMemberShipIdByUserIdAndOrgId(user_id:Int,organization_id:Int,completion: @escaping (_: Int) -> Void){

        // simple alamofire get request
        Alamofire.request(Shared.sharedInstance.membershipsUrl!).responseJSON { (response) in
            switch response.result{
                
            // in case of request success
            case.success(let data):
                self.myResponse = JSON(data)
                
                // looping the memberships
                for MembershipItem in self.myResponse.arrayValue {
                    
                    // checking if the organization id in the membership item is equal to the selected organization
                    if((MembershipItem["organization_id"].intValue == organization_id) && (MembershipItem["user_id"].intValue == user_id)){
                        
                      completion(MembershipItem["id"].intValue)
                        
                    }
                }

            case.failure(let error):
                print("request failed with ",error)
                completion(0)
            }
        }
        
       
    }
    
}
