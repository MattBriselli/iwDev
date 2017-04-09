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
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        
    }
}
