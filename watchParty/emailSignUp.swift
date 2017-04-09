//
//  emailSignUp.swift
//  watchParty
//
//  Created by Matt Briselli on 4/9/17.
//  Copyright © 2017 Matt Briselli. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import FirebaseAuth

class emailSignUp: UIViewController {
    
    @IBOutlet var watchParty: UILabel!
    @IBOutlet var email: UITextField!
    @IBOutlet var pword: UITextField!
    @IBOutlet var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stylings()
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
    
    func stylings() {
        self.watchParty.center.x = view.center.x
        self.watchParty.center.y = view.center.y * 0.25
        self.email.center.x = view.center.x
        self.email.center.y = view.center.y * 0.9
        self.pword.center.x = view.center.x
        self.pword.center.y = view.center.y
        self.signUp.layer.cornerRadius = 10;
        self.signUp.center.x = view.center.x
        self.signUp.center.y = view.center.y * 1.15
    }
}
