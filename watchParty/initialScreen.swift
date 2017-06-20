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
import FBSDKLoginKit
import FBSDKShareKit
import FBSDKCoreKit

class ViewController: UIViewController {
    
//    static private var pList: CFPropertyList

    @IBOutlet var wpTitle: UILabel!
    @IBOutlet var emailLogin: UIButton!
    @IBOutlet var fbLogin: UIButton!
    @IBOutlet var emailSignUp: UIButton!
    
    override func viewDidLoad() {
        FIRApp.configure()
        
        stylings()
        
//        UserProfile.pLis
        
        
        if let accessToken = FBSDKAccessToken.current() {
            print("\n\n\n\n")
            print(accessToken)
        } else {
            print("\n\n\n\nNO")
        }
        
        if let accessToken = AccessToken.current {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView")
            self.present(mainViewController, animated:true, completion:nil)
        }
        
        if (loggedIn()) {
            let loginManager = LoginManager()
//            loginManager.loginBehavior = LoginBehavior.web
            loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
                    FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                        if let error = error {
                            print("error 2\(error)")
                        }
                    }
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView")
                    self.present(mainViewController, animated:true, completion:nil)
                    
                }
                
            }
            
        }
        
    }
    
    func loggedIn() -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                print("error")
                return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            let people = try managedContext.fetch(fetchRequest)
            print(people.count, people)
            if (people.count != 0) {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    

    @IBAction func FBLogin(_ sender: Any) {
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
                    if let error = error {
                        print("error 2\(error)")
                    }
                }
                
                self.storeUser(token: accessToken.authenticationToken)
                
            }
            
        }
    }
    
    func storeUser(token: String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(token, forKeyPath: "credential")
        person.setValue("FB", forKeyPath: "method")
        
        do {
            try managedContext.save()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView")
            self.present(mainViewController, animated:true, completion:nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func stylings() {
        self.wpTitle.center.x = view.center.x
        self.wpTitle.center.y = view.center.y * 0.25
        
        self.emailLogin.layer.cornerRadius = 10
        self.emailLogin.center.x = view.center.x
        self.emailLogin.center.y = view.center.y * 0.85
        self.fbLogin.layer.cornerRadius = 10
        self.fbLogin.center.x = view.center.x
        self.fbLogin.center.y = view.center.y
        self.emailSignUp.layer.cornerRadius = 10
        self.emailSignUp.center.x = view.center.x
        self.emailSignUp.center.y = view.center.y * 1.15
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

