//
//  OrganisationsCell.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit

// Organization Cell for the TableView which displays all the organizations
class OrganisationsCell: UITableViewCell {

    // default image for the Organization cell
    var organisationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    

    override func layoutSubviews() {
       
        super.layoutSubviews()
        
        // text label which conatins the organization's Name
        textLabel?.frame = CGRect(x: 100, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        }
    
    
    // init method of the cell (contains all the constraints(autolayout))
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(organisationImageView)

        
        
        // x,y,width,height anchors for the constraints
        organisationImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        organisationImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        organisationImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        organisationImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
          }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  }
