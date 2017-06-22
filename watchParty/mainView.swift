//
//  mainView.swift
//  watchParty
//
//  Created by Matt Briselli on 4/9/17.
//  Copyright © 2017 Matt Briselli. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin

class mainView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            print("\n\n\n")
            print(accessToken)
            print("\n\n\n")
        }
    }

}
