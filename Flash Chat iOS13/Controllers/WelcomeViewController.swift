//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    // Serves to animate the text
    @IBOutlet weak var titleLabel: CLTypingLabel! //Declaring it with the custom type (Pod)
    
    
    override func viewWillAppear(_ animated: Bool) {
        //code execution that happens before the screen appear
        super.viewWillAppear(animated)
        //hiding the navigation bar
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //override the function view will desapear (code execution that happens before the screen leaves)
        super.viewWillDisappear(animated)
        //showing the navigation bar again for the next screen
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = K.appTitle
        //navigationController?.navigationBar.backgroundColor = .white
    }
}
