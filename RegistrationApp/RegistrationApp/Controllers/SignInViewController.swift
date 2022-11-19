//  SignInViewController.swift
//  RegistrationApp
//  Created by Carolina on 18.11.22.

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var signInButton: UIButton!
    @IBOutlet private weak var enterEmail: UITextField!
    @IBOutlet private weak var enterPassword: UITextField!
    @IBOutlet private weak var errorPassword: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction func createAccount() {
    }
    
    @IBAction func signIn() {
    }
    
    // переход по конпке signIn из createVC в SignInVC
    @IBAction func unwindToSign(_ unwindSegue: UIStoryboardSegue) {
    }
    // MARK: - Functions
    func setupUI() {
        signInButton.layer.cornerRadius = signInButton.frame.size.height / 2
    }
}
