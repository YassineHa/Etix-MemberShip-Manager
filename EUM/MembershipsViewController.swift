//
//  MembershipsViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit



// MemberShip View Controller which displays the selected Organization's Users
class MembershipsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

     // the current User Manager who calls the View Model for the MVVM pattern
    @IBOutlet var usersManager : UsersManager!
    
    // the client which contains all the alamofire Methods
    @IBOutlet var client : Client!
    
    // the current TableView
    @IBOutlet weak var membershipsTableView: UITableView!
    
    // the navigation Bar title which displays the Organization Name
    @IBOutlet weak var navBarTitle: UINavigationItem!

    // the cell identifier
    var cellId = "MembershipsCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // displaying the navBar title
        navBarTitle.title = ("\(Shared.sharedInstance.selectedOrganization.name) Users")
 
        // registering the cell identifier to the current TableView
        membershipsTableView.register(UsersCell.self, forCellReuseIdentifier: cellId)
        
        // allows editing and multiple slection in the cell and the table view
        membershipsTableView.allowsMultipleSelectionDuringEditing = true
        
        // fetching all the Users of the selected Organization from the DB and displaying them through the TableView from the userManager
        usersManager.fetchAndAddUsersByOrganisation{
            DispatchQueue.main.async(execute: {self.membershipsTableView.reloadData();})
        }
    }
    
    // Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersManager.numberOfItemsInSection(section: section)    // the number of rows in the table View
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // init the cell as a UsersCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UsersCell
        
        
        // instantiate the User view model to fetch it into the cell
        let userViewModel : UserViewModel
        userViewModel = UserViewModel(aUser: usersManager.userForItemAtIndexPath(indexPath: indexPath))
        
        // display the default image
        cell.userImageView.image =  UIImage(named: "profile")
        
        // display the name of the user
        cell.textLabel?.text = userViewModel.nameText

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
    
    // the swipe editing Style for Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        client.searchMemberShipIdByUserIdAndOrgId(user_id: UserViewModel(aUser: usersManager.userForItemAtIndexPath(indexPath: indexPath)).userId!, organization_id: Shared.sharedInstance.selectedOrganization.id){
            
            (searchedMembershipId: Int) in
            
            self.client.DeleteMemberShip(deletedMembershipId: searchedMembershipId)
        }
        // Deleteing a membership
        client.DeleteMemberShip(deletedMembershipId: 1)
        
        // update the list of users by removing the user
        usersManager.removeItemAtIndexPath(indexPath: indexPath)
        
        // fill the shared list of users
        usersManager.fillSharedlistOfUsers()
        
        // reload the data in the current tableView
        membershipsTableView.reloadData()
    
    }
    
    @IBAction func backAction(_ sender: Any) {
        Shared.sharedInstance.usersByOrganization.removeAll()
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
