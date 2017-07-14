//
//  AddingConfirmationViewController.swift
//  EUM
//
//  Created by Yassine-Ha on 11/07/2017.
//  Copyright © 2017 YassineHa. All rights reserved.
//

import UIKit


// The PopUp of confirmation when adding a User to a specific Organization
class AddingConfirmationViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var warningText: UILabel!
    
    @IBOutlet var client : Client!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPopUpDisplay()
    }
    
    // init the design of the PopUp
    func  initPopUpDisplay() {
        mainView.layer.cornerRadius = 5
        mainView.clipsToBounds = true
        mainView.layer.masksToBounds = true
        
        cancelBtn.layer.cornerRadius = 5
        cancelBtn.clipsToBounds = true
        cancelBtn.layer.masksToBounds = true
        
        confirmBtn.layer.cornerRadius = 5
        confirmBtn.clipsToBounds = true
        confirmBtn.layer.masksToBounds = true
        
        warningText.text = "You are about to add the user \(Shared.sharedInstance.selectedUser.name.uppercased()) to the organisation \(Shared.sharedInstance.selectedOrganization.name.uppercased()) , to confirm tap the confirm button"
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func ConfirmAction(_ sender: Any) {

        // adding a memberShip 
        client.addMembership(user_id: Shared.sharedInstance.selectedUser.id,organization_id: Shared.sharedInstance.selectedOrganization.id)
        
        // returning the MemberShip view Controller
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let membershipsViewController = storyBoard.instantiateViewController(withIdentifier: "MembershipsViewController") as! MembershipsViewController
        self.present(membershipsViewController, animated: true, completion: nil)
        
    }
    
    
}
