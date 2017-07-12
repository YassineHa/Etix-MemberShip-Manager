//
//  OrganisationsViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


// Organisation View Controller which displays all the Organizations
class OrganisationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    // the current TableView
    @IBOutlet weak var organisationTableView: UITableView!
    
    // the cell identifier
    var cellId = "OrganisationsCell"
    
    // list of all the Organizations
    var organisations = [Organization]()
    
    // the JSON response of the Alamofire Request
    var myResponse : JSON = nil
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // registering the cell identifier to the current TableView
        organisationTableView.register(OrganisationsCell.self, forCellReuseIdentifier: cellId)
        
        // fetching all the organizations from the DB and displaying them through the TableView
        fetchAndAddOrganisations()
        
        // clear all The values users by selected Organization to refill it when needed
        Shared.sharedInstance.usersByOrganization.removeAll()
        
   
    }
    
   
    
    
    //_____________________________Table View Functions________________________________________________________________
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return organisations.count  // the number of rows in the table View
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //init the cell as a OrganisationsCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! OrganisationsCell
        
        let organisation = organisations[indexPath.row]
    
        // display the default image
        cell.organisationImageView.image =  UIImage(named: "organization")
        
        // display the name of the organization
        cell.textLabel?.text = organisation.name
        
        
        return cell
        
    }
    
    // when a organization is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // present the next ViewController(MembershipsViewController)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let membershipsViewController = storyBoard.instantiateViewController(withIdentifier: "MembershipsViewController") as! MembershipsViewController
        
        // fill the shared selectedOrganization
        Shared.sharedInstance.selectedOrganization = organisations[indexPath.row]
        
        self.present(membershipsViewController, animated: true, completion: nil)
        
    }
    
    // set the height of a Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //________________________________________________________________________________________________________________
    
    
  
    // parsing and fetching all the organizations from The DB
    func fetchAndAddOrganisations() {
        
        // simple Get request for displaying
        Alamofire.request(Shared.sharedInstance.organizationsUrl!).responseJSON { (response) in
            
            switch response.result{
                
            // in case of request success
            case.success(let data):
                self.myResponse = JSON(data)
                
                // filling the organizations array
                for item in self.myResponse.arrayValue {
                    print(item["name"].stringValue)
                    let organisation = Organization(id: item["id"].intValue, name: item["name"].stringValue)
                    self.organisations.append(organisation)
                    DispatchQueue.main.async(execute: {self.organisationTableView.reloadData();})
                }
                
                
            // in case of request failure (404,..)
            case.failure(let error):
                print("request failed with ",error)
            }
 
            
        }
  
    }
    
    
    
   
    
}
