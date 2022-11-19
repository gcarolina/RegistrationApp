//  SecretCodeViewController.swift
//  RegistrationApp
//  Created by Carolina on 20.11.22.

import UIKit

class SecretCodeViewController: UIViewController {
    var email: String?
    
    // MARK: - IBOutlets
    @IBOutlet private weak var secretCodeTF: UITextField!
    @IBOutlet private weak var enterCodeLbl: UILabel!
    @IBOutlet weak var errorSecretCode: UILabel!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if email != nil {
            enterCodeLbl.text = "Please enter code from \(email ?? " ")"
        }
    }
    
    @IBAction func enterSecretCodeAction(_ sender: UITextField) {
//        if let confEmailText = sender.text, !confEmailText.isEmpty,
//           let emailText = emailTF.text, !emailText.isEmpty {
//            isConfEmail = isEmailCofirm(email1: confEmailText,
//                                       email1: emailText)
//        } else {
//            isConfEmail = false
//        }
//        errorSecretCode.isHidden = isConfEmail
    }
    
    static func isEmailCofirm(email1: String,
                             email2: String) -> Bool {
        email1 == email2
    }
    
    // MARK: - Navigation

}
