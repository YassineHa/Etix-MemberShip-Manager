//
//  Membership.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//


// model of the Membership (defines relationships betwen Organizations and users)
class Membership {
    
    let id: Int                     // id of the membership
    let user_id: Int                // id of the user of a specific organization
    let organization_id: Int        // id of the Organization

    init(anId:Int, aUser_id:Int, anOrganization_id:Int){
        id = anId
        user_id = aUser_id
        organization_id = anOrganization_id
    }
}
