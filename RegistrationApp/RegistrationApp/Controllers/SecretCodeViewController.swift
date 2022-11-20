//  SecretCodeViewController.swift
//  RegistrationApp
//  Created by Carolina on 20.11.22.

import UIKit

class SecretCodeViewController: UIViewController {
    var email: String?
    private var code = ""
    private var isCodeMatch = false
    
    var nameOfPearson: String?
    // MARK: - IBOutlets
    @IBOutlet private weak var secretCodeTF: UITextField!
    @IBOutlet private weak var enterCodeLbl: UILabel!
    @IBOutlet weak var errorSecretCode: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        code = random(digits: 6)
        
        if email != nil {
            enterCodeLbl.text = "Please enter code \(code) from \(email ?? " ")"
        }
    }
    
    @IBAction func enterSecretCodeAction(_ sender: UITextField) {
        if let codeText = sender.text, !codeText.isEmpty {
            isCodeMatch = VerificationServices.isCodeConfirm(code1: codeText, code2: code)
        } else {
            isCodeMatch = false
        }
        errorSecretCode.isHidden = isCodeMatch
        
        if isCodeMatch {
            let storyboard = UIStoryboard(name: "SecretCodeStoryboard", bundle: nil)
            if let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
                navigationController?.pushViewController(welcomeVC, animated: true)
                welcomeVC.name = nameOfPearson
            }
        }
    }
    
    // MARK: - Navigation

    // MARK: - Functions
    private func random(digits: Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }

}
