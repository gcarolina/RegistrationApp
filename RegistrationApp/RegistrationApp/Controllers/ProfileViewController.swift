//  ProfileViewController.swift
//  RegistrationApp
//  Created by Carolina on 25.11.22.

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var deleteAccount: UIButton!
    @IBOutlet private weak var logOut: UIButton!
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Actions
    @IBAction private func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func deleteAccountAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - Functions
    private func setupUI() {
        deleteAccount.layer.cornerRadius = deleteAccount.frame.size.height / 2
        logOut.layer.cornerRadius = logOut.frame.size.height / 2
    }
}
