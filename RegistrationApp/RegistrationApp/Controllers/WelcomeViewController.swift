//  WelcomeViewController.swift
//  RegistrationApp
//  Created by Carolina on 20.11.22.

import UIKit

class WelcomeViewController: UIViewController {
    var name: String?
    // MARK: - IBOutlets
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if name != nil {
            welcomeLabel.text = "\(name ?? " ") welcome to our app!"
        }
    }

    // MARK: - Actions
    // переход по конпке continue из WelcomeVC в SignInVC
    @IBAction func continueAction() {
        performSegue(withIdentifier: "unwindToSignInVCFromWelcome", sender: "")
    }
    
    // MARK: - Functions
    func setupUI() {
        continueButton.layer.cornerRadius = continueButton.frame.size.height / 2
    }
}
