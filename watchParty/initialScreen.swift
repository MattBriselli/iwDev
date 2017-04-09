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
    @IBOutlet var emailLogin: UIButton!
    @IBOutlet var fbLogin: UIButton!
    @IBOutlet var emailSignUp: UIButton!
    
    override func viewDidLoad() {
        FIRApp.configure()
        
        if (loggedIn()) {
            
        } else {
            wpTitle.center.x = view.center.x
            wpTitle.center.y = view.center.y * 0.25
            
            emailLogin.layer.cornerRadius = 10;
            emailLogin.center.x = view.center.x
            emailLogin.center.y = view.center.y * 0.85
            fbLogin.layer.cornerRadius = 10;
            fbLogin.center.x = view.center.x
            fbLogin.center.y = view.center.y
            emailSignUp.layer.cornerRadius = 10;
            emailSignUp.center.x = view.center.x
            emailSignUp.center.y = view.center.y * 1.15
            
        }
        
    }
    
    func loggedIn() -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            if (people.count == 1) {
                print (people[0].value(forKey: "username"), people[0].value(forKey: "password"))
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    

    @IBAction func loginButtonClickedFB(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.loginBehavior = LoginBehavior.systemAccount
        loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                    // ...
                    if let error = error {
                        // ...
                        print("error 2")
                    }
                }
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView")
                self.present(mainViewController, animated:true, completion:nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

