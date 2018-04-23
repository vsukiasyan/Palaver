//
//  LoginVC.swift
//  Palaver
//
//  Created by Vic Sukiasyan on 4/22/18.
//  Copyright © 2018 Vic Sukiasyan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func createAccountBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    @IBAction func closePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
