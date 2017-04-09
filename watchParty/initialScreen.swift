//
//  initialScreen.swift
//  watchParty
//
//  Created by Matt Briselli on 4/9/17.
//  Copyright © 2017 Matt Briselli. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth
import FacebookCore
import FacebookLogin
import FacebookShare
import SocketIO

class ViewController: UIViewController {

    @IBOutlet var wpTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wpTitle.center.x = view.center.x
        wpTitle.center.y = view.center.y * 0.25
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

