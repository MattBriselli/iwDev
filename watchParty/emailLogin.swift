//
//  emailLogin.swift
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

class emailLogin: UIViewController {
    
    @IBOutlet var watchParty: UILabel!
    @IBOutlet var email: UITextField!
    @IBOutlet var pword: UITextField!
    @IBOutlet var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stylings()
    }

    @IBAction func emailLogin(_ sender: Any) {
        
        if self.email.text == "" || self.pword.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().createUser(withEmail: self.email.text!, password: self.pword.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    self.storeUser()
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    func storeUser() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(self.email.text, forKeyPath: "username")
        person.setValue(self.pword.text, forKeyPath: "password")
        person.setValue("email", forKeyPath: "method")
    
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
        self.watchParty.center.x = view.center.x
        self.watchParty.center.y = view.center.y * 0.25
        self.email.center.x = view.center.x
        self.email.center.y = view.center.y * 0.9
        self.pword.center.x = view.center.x
        self.pword.center.y = view.center.y
        self.login.layer.cornerRadius = 10;
        self.login.center.x = view.center.x
        self.login.center.y = view.center.y * 1.15
    }
}
