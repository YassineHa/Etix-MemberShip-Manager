//
//  Membership.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

// model of the Membership (defines relationships betwen Organizations and users) (struct for passing by values and not by references)
struct Membership {
    
    let id: Int                     // id of the membership
    let user_id: Int                // id of the user of a specific organization
    let organization_id: Int        // id of the Organization
}
