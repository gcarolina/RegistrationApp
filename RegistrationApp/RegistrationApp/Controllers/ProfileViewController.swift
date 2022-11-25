//
//  ProfileViewController.swift
//  RegistrationApp
//
//  Created by Carolina on 25.11.22.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var deleteAccount: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
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
    
    @IBAction func logOutAction() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func deleteAccountAction() {
        UserDefaultsService.cleanUserDefaults()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    // MARK: - Functions
    private func setupUI() {
        deleteAccount.layer.cornerRadius = deleteAccount.frame.size.height / 2
        logOut.layer.cornerRadius = logOut.frame.size.height / 2
    }
}
