//
//  OrganisationsViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit


// Organisation View Controller which displays all the Organizations
class OrganisationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // the current Organization Manager who calls th View Model for the MVVM patern
    @IBOutlet var organizationsManager : OrganizationsManager!
    
    // the current TableView
    @IBOutlet weak var organisationTableView: UITableView!
    
    // the cell identifier
    var cellId = "OrganisationsCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registering the cell identifier to the current TableView
        organisationTableView.register(OrganisationsCell.self, forCellReuseIdentifier: cellId)
        
        // fetching all the organizations from the DB and displaying them through the TableView
        organizationsManager.fetchOrganizations {
           DispatchQueue.main.async(execute: {self.organisationTableView.reloadData();})
        }
    }
    
    // Table View Functions 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organizationsManager.numberOfItemsInSection(section: section)  // the number of rows in the table View
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //init the cell as a OrganisationsCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrganisationsCell
    
        //instantiate the Organization view model to fetch it into the cell
        let organizationViewModel : OrganizationViewModel
        organizationViewModel = OrganizationViewModel(anOrganization: organizationsManager.organisationsForItemAtIndexPath(indexPath: indexPath))
        
        // display the default image
        cell.organisationImageView.image =  UIImage(named: "organization")
        
        // display the name of the organization from the view model
        cell.textLabel?.text = organizationViewModel.nameText
        
        return cell
    }
    
    // when a organization is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // present the next ViewController(MembershipsViewController)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let membershipsViewController = storyBoard.instantiateViewController(withIdentifier: "MembershipsViewController") as! MembershipsViewController
        
        // fill the shared selectedOrganization
        organizationsManager.fillSharedSelectedOrganization(indexPath: indexPath)
        
        self.present(membershipsViewController, animated: true, completion: nil)
    }
    
    // set the height of a Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
