//
//  UsersViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.

import UIKit


// Users View Controller which displays the available users for the selected Organization
class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    // the current User Manager who calls th View Model for the MVVM patern
    @IBOutlet var usersManager : UsersManager!
    
    // the current TableView
    @IBOutlet weak var usersTableView: UITableView!
    
     // the cell identifier
    var cellId = "UsersCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // registering the cell identifier to the current TableView
        usersTableView.register(UsersCell.self, forCellReuseIdentifier: cellId)
       
        //fetching all the available Users of the selected Organization from the DB and displaying them through the TableView
        usersManager.fetchAvailableUsers{
            DispatchQueue.main.async(execute: {self.usersTableView.reloadData();})
        }
    }
  
    //_Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersManager.numberOfItemsInSection(section: section)      // the number of rows in the table View
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //init the cell as a UsersCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UsersCell
        
        //instantiate the User view model to fetch it into the cell
        let userViewModel : UserViewModel
        userViewModel = UserViewModel(aUser: usersManager.userForItemAtIndexPath(indexPath: indexPath))
        
        // display the default image
        cell.userImageView.image =  UIImage(named: "profile")
        
        // display the name of the user
        cell.textLabel?.text = userViewModel.nameText
        return cell
    }
    
    
    // when a User is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Present the confirmation View Controller
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addingConfirmationViewController = storyBoard.instantiateViewController(withIdentifier: "AddingConfirmationViewController") as! AddingConfirmationViewController

        // updating  the current selected User into the shared instance selectdUser
        usersManager.fillSharedSelectedUser(indexPath: indexPath)
        self.present(addingConfirmationViewController, animated: true, completion: nil)
    }
    
    // set the height of a Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func backAction(_ sender: Any) {
                 dismiss(animated: true, completion: nil)
    }
}
