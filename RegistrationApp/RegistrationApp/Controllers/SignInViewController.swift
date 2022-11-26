//  SignInViewController.swift
//  RegistrationApp
//  Created by Carolina on 18.11.22.

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var enterEmail: UITextField!
    @IBOutlet private weak var enterPassword: UITextField!
    @IBOutlet private weak var errorPassword: UILabel!
    @IBOutlet private weak var errorEmailLbl: UILabel!
    
    private var isValidEmail = false
    private var isValidPass = false
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        
        errorPassword.isHidden = true
        let isLogged = UserDefaultsService.checkIfUserIsLoggedIn()
        if isLogged {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainVC = storyboard.instantiateViewController(withIdentifier: "Main") as? UITabBarController {
                navigationController?.pushViewController(mainVC, animated: true)
            }
        }
    }
    // очистка TF
    override func viewWillAppear(_ animated: Bool) {
        enterEmail.text = ""
        enterPassword.text = ""
        errorPassword.text = ""
    }
    
    // MARK: - Actions
    @IBAction private func enterEmailAction() {
        if let email = enterEmail.text,
               !email.isEmpty,
               VerificationServices.isValidEmail(email: email) {
                    isValidEmail = true
                } else {
                    isValidEmail = false
                }
        errorEmailLbl.isHidden = isValidEmail
        errorEmailLbl.text = "Error email format"
    }
    
    @IBAction private func enterPasswordAction() {
        let weakRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        if let passText = enterPassword.text, !passText.isEmpty {
            if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: passText) {
                isValidPass = true
            } else {
                isValidPass = false
            }
            errorPassword.isHidden = isValidPass
            errorPassword.text = "Error password format"
        }
    }
    
    @IBAction private func signIn() {
        if let emailText = enterEmail.text, !emailText.isEmpty,
           let passwordText = enterPassword.text, !passwordText.isEmpty,
           let userModel = UserDefaultsService.getUserModel(),
           emailText == userModel.email, passwordText == userModel.password {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainVC = storyboard.instantiateViewController(withIdentifier: "Main") as? UITabBarController {
                navigationController?.pushViewController(mainVC, animated: true)
            }
        } else {
            errorPassword.isHidden = false
            errorPassword.text = "Error password or email"
        }
    }
    
    // переход по кнопке signIn из createVC в SignInVC
    @IBAction private func unwindToSign(_ unwindSegue: UIStoryboardSegue) {
    }
    
    // переход по конпке continue из WelcomeVC в SignInVC
    @IBAction private func unwindToFirst(_ unwindSegue: UIStoryboardSegue) {
    }
    // MARK: - Functions
    func setupUI() {
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
    }
}
