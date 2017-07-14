//
//  MembershipViewModel.swift
//  EUM
//
//  Created by Yassine-Ha on 14/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit
// the Membeership View model for the MVVM patern
class MembershipViewModel: NSObject {

    var membership : Membership = Membership(anId: 0, aUser_id: 0, anOrganization_id: 0)
    
    override init() {
        super.init()
    }
    
    init(aMembership: Membership) {
        membership = aMembership
    }
}
