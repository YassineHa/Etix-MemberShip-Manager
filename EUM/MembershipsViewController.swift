//
//  MembershipsViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


// MemberShip View Controller which displays the selected Organization Users
class MembershipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // the current TableView
    @IBOutlet weak var membershipsTableView: UITableView!
    
    // the navigation Bar title  which displays the Organization Name
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    // the list of all the membership of a specific Organization
    var membershipsByOrganisation = [Membership]()
    
    // the list of all the Users of a specific Organization
    var usersByOrganisation = [User]()
    
    // the cell identifier
    var cellId = "MembershipsCell"
    
    // the JSON response of the Alamofire Request
    var myResponse : JSON = nil
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // displaying the navBar title
        navBarTitle.title = ("\(Shared.sharedInstance.selectedOrganization.name) Users")
 
        // registering the cell identifier to the current TableView
        membershipsTableView.register(UsersCell.self, forCellReuseIdentifier: cellId)
        
        // allows editing and multiple slection in the cell and the table view
        membershipsTableView.allowsMultipleSelectionDuringEditing = true
        
        // fetching all the Users of the selected Organization from the DB and displaying them through the TableView
        fetchAndAddUsersByOrganisation()
        
    }

    
    //_____________________________Table View Functions________________________________________________________________
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersByOrganisation.count    // the number of rows in the table View
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //init the cell as a UsersCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UsersCell
        
        let user = usersByOrganisation[indexPath.row]
        
        // display the default image
        cell.userImageView.image =  UIImage(named: "profile")
        
        // display the name of the user
        cell.textLabel?.text = user.name
        
        
        return cell
        
    }
    
    // set the height of a Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    // if the row is edditable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    // the swipe editiong Style for Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        // the Url of the jsonObject to remove
        let deleteUrl = URL(string: "http://localhost:3000/memberships/\(membershipsByOrganisation[indexPath.row].id)")
        
        // simple delete alamofire Request
        Alamofire.request(deleteUrl!, method: .delete)
            .responseJSON { response in
                if let error = response.result.error {
                    // got an error while deleting, need to handle it
                   
                    print(error)
                } else {
                    print("delete ok")
                }
        }
        
        // update the list of users by removing the user
        usersByOrganisation.remove(at: indexPath.row)
        
        // update the Shared instace of the list of users by removing the user
        Shared.sharedInstance.usersByOrganization = usersByOrganisation
        
        // reload the data in the current tableView
        membershipsTableView.reloadData()
    
    
    }

    
    //________________________________________________________________________________________________________________
   
    
    // parsing and fetching all the organization Users ( by looping the memberships and fetching the users list)
    func fetchAndAddUsersByOrganisation() {
        
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
                        
                        // fetching the membership item into its model
                        let membership = Membership(id: MembershipItem["id"].intValue, user_id: MembershipItem["user_id"].intValue, organization_id: MembershipItem["organization_id"].intValue)
                        
                        // apped the membership item into the memberships list
                        self.membershipsByOrganisation.append(membership)
                        
                        // looping the users
                        for UserItem in self.myResponse["users"].arrayValue {
                           
                            // checking if the user id in the membership item is equal to the current user
                            if(MembershipItem["user_id"].intValue == UserItem["id"].intValue ){
                                let user = User(id: UserItem["id"].intValue, name: UserItem["name"].stringValue)
                                self.usersByOrganisation.append(user)
                                Shared.sharedInstance.usersByOrganization.append(user)
                                DispatchQueue.main.async(execute: {self.membershipsTableView.reloadData();})
                                
                            }
                        
                        }
                        
                    }
     
                    
                }
                
            case.failure(let error):
                print("request failed with ",error)
            }
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let organisationsViewController = storyBoard.instantiateViewController(withIdentifier: "OrganisationsViewController") as! OrganisationsViewController
        self.present(organisationsViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func addUserAction(_ sender: Any) {
        
        // presneting the next view Controller (UsersViewController)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let usersViewController = storyBoard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        self.present(usersViewController, animated: true, completion: nil)
  
    }
    
    

   }
