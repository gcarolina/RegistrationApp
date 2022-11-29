//  SecretCodeViewController.swift
//  RegistrationApp
//  Created by Carolina on 20.11.22.

import UIKit

final class SecretCodeViewController: UIViewController {
    var userModel: UserModel?
    private var code = ""
//    private var isCodeMatch = false
    var sleepTime = 3
    // MARK: - IBOutlets
    @IBOutlet private weak var secretCodeTF: UITextField!
    @IBOutlet private weak var enterCodeLbl: UILabel!
    @IBOutlet private weak var errorSecretCode: UILabel!
    @IBOutlet private weak var constraintForKeyboard: NSLayoutConstraint!
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        
        code = random(digits: 6)
        enterCodeLbl.text = "Please enter code \(code) from \(userModel?.email ?? " ")"
    }
    
    // работает при каждом изменении в TF
//    @IBAction private func enterSecretCodeAction(_ sender: UITextField) {
//        if let codeText = sender.text, !codeText.isEmpty {
//            isCodeMatch = VerificationServices.isCodeConfirm(code1: codeText, code2: code)
//        } else {
//            isCodeMatch = false
//        }
//        errorSecretCode.isHidden = isCodeMatch
//
//        // переход из SecretCodeVC в WelcomeVC
//        if isCodeMatch {
//            let storyboard = UIStoryboard(name: "SecretCodeStoryboard", bundle: nil)
//            if let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
//                navigationController?.pushViewController(welcomeVC, animated: true)
//                welcomeVC.userModel = userModel
//            }
//        }
//    }
    
    // работает при нажатии на return
    @IBAction private func enterCodeAction(_ sender: UITextField) {
        guard let text = sender.text,
              !text.isEmpty, text == code.description else {
            errorSecretCode.text = "Error code. Please wait \(sleepTime) seconds"
            sender.isUserInteractionEnabled = false
            errorSecretCode.isHidden = false
            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispatchAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errorSecretCode.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        let storyboard = UIStoryboard(name: "SecretCodeStoryboard", bundle: nil)
        if let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
            navigationController?.pushViewController(welcomeVC, animated: true)
            welcomeVC.userModel = userModel
        }
    }

    // MARK: - Functions
    private func random(digits: Int) -> String {
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
       
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        constraintForKeyboard.constant -= keyboardSize.height / 2
    }
       
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        constraintForKeyboard.constant += keyboardSize.height / 2
    }
}
