//
//  InfoViewController.swift
//  RegistrationApp
//
//  Created by Carolina on 25.11.22.
//

import UIKit

class InfoViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
