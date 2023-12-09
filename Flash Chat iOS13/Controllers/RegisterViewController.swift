//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBAction func registerPressed(_ sender: UIButton) {
        //after adding cocoa pods and the firebase pod, to the Podfile, we can use its functionalities. following the documentation. Register, login, logout,
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            //calling firebase to insert data. Creating user with password and email
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {//treating for error
                    print(e.localizedDescription)// when error: print error readable for users and in their language
                } else {// If no errors
                    //follow to the next VC
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        } else {
            //warning the user
            emailTextfield.placeholder = K.forgotEmail
            passwordTextfield.placeholder = K.forgotPassword
        }
    }
}
