//  WelcomeViewController.swift
//  RegistrationApp
//  Created by Carolina on 20.11.22.

import UIKit

final class WelcomeViewController: UIViewController {
    var userModel: UserModel?
    // MARK: - IBOutlets
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Actions
    // переход по кнопке continue из WelcomeVC в SignInVC + запись данных в бд
    @IBAction private func continueAction() {
        guard let userModel = userModel else { return }
                UserDefaultsService.saveUserModel(userModel: userModel)
        performSegue(withIdentifier: "unwindToSignInVCFromWelcome", sender: "")
    }
    
    // MARK: - Functions
    private func setupUI() {
        continueButton.layer.cornerRadius = continueButton.frame.size.height / 2
        welcomeLabel.text = "\(userModel?.name ?? " ") welcome to our app!"
    }
}
