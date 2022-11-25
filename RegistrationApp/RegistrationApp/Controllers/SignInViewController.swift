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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // записать в UserDefaultsService булевое значение залогирован ли пользователь
        if let _ = UserDefaultsService.getUserModel() {
            performSegue(withIdentifier: "goToTBVC", sender: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enterEmail.text = ""
        enterPassword.text = ""
    }
    
    // MARK: - Actions
//    @IBAction func enterEmailAction() {
//    }
//
//    @IBAction func enterPasswordAction() {
//    }
    
    @IBAction private func signIn() {
        errorPassword.isHidden = true
        guard let emailText = enterEmail.text, !emailText.isEmpty,
              let passwordText = enterPassword.text, !passwordText.isEmpty,
              let userModel = UserDefaultsService.getUserModel(),
              emailText == userModel.email, passwordText == userModel.password else {
            errorPassword.isHidden = false
            return
        }
        performSegue(withIdentifier: "goToTBVC", sender: nil)
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
