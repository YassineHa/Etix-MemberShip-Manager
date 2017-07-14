//
//  OrganizationViewModel.swift
//  EUM
//
//  Created by Yassine-Ha on 14/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

// the Organization View model for the MVVM patern
class OrganizationViewModel: NSObject {

    var organization : Organization = Organization(anId: 0, aName: "")
    
    override init() {
         super.init()
    }
    
     init(anOrganization: Organization) {
        organization = anOrganization
    }
  
    var nameText : String? {
        return ("Name: \(organization.name)")
    }
}
