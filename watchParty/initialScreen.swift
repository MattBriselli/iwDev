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

class ViewController: UIViewController {
    
//    static private var pList: CFPropertyList

    @IBOutlet var wpTitle: UILabel!
    @IBOutlet var emailLogin: UIButton!
    @IBOutlet var emailSignUp: UIButton!
    
    override func viewDidLoad() {
        FirebaseApp.configure()
        
        stylings()
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
        self.emailSignUp.layer.cornerRadius = 10
        self.emailSignUp.center.x = view.center.x
        self.emailSignUp.center.y = view.center.y
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

