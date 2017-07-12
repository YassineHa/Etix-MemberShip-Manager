//
//  UsersViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// Users View Controller which displays the available users for the selected Organization
class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    // the current TableView
    @IBOutlet weak var usersTableView: UITableView!
   
    // the JSON response of the Alamofire Request
    var myResponse : JSON = nil
    
    // the list of all the available users of a specific Organization  to display
    var users = [User]()
    
     // the cell identifier
    var cellId = "UsersCell"
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // registering the cell identifier to the current TableView
        usersTableView.register(UsersCell.self, forCellReuseIdentifier: cellId)
       
        //fetching all the available Users of the selected Organization from the DB and displaying them through the TableView
        fetchAndAddUsers()
      
    }
    
    
    
    
    
    //_____________________________Table View Functions________________________________________________________________
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count      // the number of rows in the table View
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //init the cell as a UsersCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UsersCell
        
        let user = users[indexPath.row]
        
        // display the default image
        cell.userImageView.image =  UIImage(named: "profile")
        
        // display the name of the user
        cell.textLabel?.text = user.name
        
        
        return cell
        
    }
    
    // when a User is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Present the confirmation View Controller
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addingConfirmationViewController = storyBoard.instantiateViewController(withIdentifier: "AddingConfirmationViewController") as! AddingConfirmationViewController

        // updating  the current selected User into the shared instance selectdUser
        Shared.sharedInstance.selectedUser = users[indexPath.row]
        self.present(addingConfirmationViewController, animated: true, completion: nil)
        

    }
    
    // set the height of a Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    //________________________________________________________________________________________________________________
    

    
    // parsing and fetching all the available Users ( by looping the subtract the shared list of users by selected Organization from all the users)
    func fetchAndAddUsers() {

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
                    if(Shared.sharedInstance.usersByOrganization.contains(where: { $0.id == user.id })){
                        
                        
                    }
                    else{
                        self.users.append(user)
                        DispatchQueue.main.async(execute: {self.usersTableView.reloadData();})
                        
                    }
                }
             
            // in case of request failure
            case.failure(let error):
                print("request failed with ",error)
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
                 dismiss(animated: true, completion: nil)
    }
    
    
    
}
