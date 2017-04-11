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

class mainView: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let accessToken = AccessToken.current {
            print("\n\n\n")
            print(accessToken)
            print("\n\n\n")
        }
        
        let socket = SocketIOClient.init(socketURL: URL.init(string: "https://koffee-e5c27.firebaseapp.com")!)
        socket.on("connect") {data, ack in
            print("\n\n\n")
            print("socket connected")
            print("\n\n\n")
        }
        
        socket.connect()
        
        
    }

}
