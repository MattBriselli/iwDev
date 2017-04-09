//
//  emailLogin.swift
//  watchParty
//
//  Created by Matt Briselli on 4/9/17.
//  Copyright © 2017 Matt Briselli. All rights reserved.
//

import UIKit
import CoreData

class emailLogin: UIViewController {
    
    @IBOutlet var watchParty: UILabel!
    @IBOutlet var email: UITextField!
    @IBOutlet var pword: UITextField!
    @IBOutlet var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func emailLogin(_ sender: Any) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(email.text, forKeyPath: "username")
        person.setValue(pword.text, forKeyPath: "password")
        
        do {
            try managedContext.save()
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView")
            self.present(mainViewController, animated:true, completion:nil)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
