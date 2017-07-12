//
//  OrganizationViewModel.swift
//  EUM
//
//  Created by Yassine-Ha on 12/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

class OrganizationViewModel: NSObject {
    
    @IBOutlet var client : Client!
    
    // list of all the Organizations
    var organisations = [Organization]()
    
    //fetching all the  Organizations by completion (function wrapped up into a parameter)
    func fetchOrganizations(completion : @escaping () ->()) {
        client.fetchAndAddOrganisations {
            organisations in self.organisations = organisations ?? [Organization]()
            completion()
        }
    }
    
    //return the number of Organization item
    func numberOfItemsInSection(section: Int) -> Int {
        return organisations.count
    }
    
    // fill the shared selected Organization
    func fillSharedSelectedOrganization(indexPath : IndexPath){
       Shared.sharedInstance.selectedOrganization = organisations[indexPath.row]
    }
    
    //return the organization name per indexPath
    func titleForItemAtIndexPath(indexPath : IndexPath) -> String {
        return organisations[indexPath.row].name
    }
}
