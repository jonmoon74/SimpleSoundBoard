//
//  LoginViewController.swift
//  SimpleSoundBoard
//
//  Created by Jon Moon on 22/07/2018.
//  Copyright © 2018 Jon Moon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var joinIButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func joinInButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: {(user, error) in
            print ("We tried to sign in")
            if error != nil {
                print ("We have an error:\(String(describing: error))")
                Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    if error != nil {
                        print ("We have an error:\(String(describing: error))")
                    } else {
                        print ("Successfully created user")
                    }
                })
            } else {
                print ("We signed in successfully")
            }
            self.performSegue(withIdentifier: "SignInSegue", sender: nil)
        })
        
    }
    
    
}
