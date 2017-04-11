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
import SocketIO

class mainView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            print(accessToken)
        }
        
    }

}
