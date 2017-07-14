//
//  Organization.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

// model of the organization
class Organization {
    
    let id: Int             //id of the organization
    let name: String        //name of the organization
    
    // init of the organization model
    init(anId:Int, aName:String){
        id = anId
        name = aName
    }
}
