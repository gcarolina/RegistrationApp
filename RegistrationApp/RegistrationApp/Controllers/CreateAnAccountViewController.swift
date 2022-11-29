//  CreateAnAccountViewController.swift
//  RegistrationApp
//  Created by Carolina on 18.11.22.

import UIKit

final class CreateAnAccountViewController: UIViewController {
    // MARK: - IBOutlets
    
    /// email
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var errorEmailLbl: UILabel!
    /// name
    @IBOutlet private weak var nameTF: UITextField!
    /// password
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var errorPasswordLbl: UILabel!
    /// password indicators
    @IBOutlet private var strongPassIndicatorsViews: [UIView]!
    /// confirm password
    @IBOutlet private weak var confPasswordTF: UITextField!
    @IBOutlet private weak var confPasswordLbl: UILabel!
    /// continue button (чтобы enable/disable использовать)
    @IBOutlet private weak var continueBtn: UIButton!
    /// scrollView (чтобы приподнимать scrollView при открытой клавиатуре)
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
    
    // MARK: - Properties
    private var isValidEmail = false { didSet { updateContinueBtnState() }}
    private var isConfPass = false { didSet { updateContinueBtnState() }}
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() }}
    
    // MARK: - Actions
    
    @IBAction private func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationServices.isValidEmail(email: email) {
            isValidEmail = true
        } else {
            isValidEmail = false
        }
        errorEmailLbl.isHidden = isValidEmail
    }
    
    @IBAction private func passwTFAction(_ sender: UITextField) {
        if let passText = sender.text, !passText.isEmpty {
            passwordStrength = VerificationServices.isValidPassword(pass: passText)
        } else {
            passwordStrength = .veryWeak
        }
        errorPasswordLbl.isHidden = passwordStrength != .veryWeak
        setUpPasswordIndicators()
        
        guard let passwordText = sender.text, !passwordText.isEmpty, let confPassText = confPasswordTF.text, VerificationServices.isPassConfirm(pass1: passwordText, pass2: confPassText) else {
            return
        }
    }
    
    // переход по конпке SignIn из WelcomeVC в SignInVC
    @IBAction private func signInAction() {
        performSegue(withIdentifier: "unwindToSignInVC", sender: "")
    }
    
    @IBAction private func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text, !confPassText.isEmpty,
           let passText = passwordTF.text, !passText.isEmpty {
            isConfPass = VerificationServices.isPassConfirm(pass1: passText,
                                                            pass2: confPassText)
        } else {
            isConfPass = false
        }
        confPasswordLbl.isHidden = isConfPass
    }
    
    // MARK: - Navigation
    // переход от CreateVC к SecretCodeVC
    @IBAction private func continueAction() {
        if let emailText = emailTF.text, !emailText.isEmpty,
           let passwordText = passwordTF.text, !passwordText.isEmpty {
            
            let userModel = UserModel(name: nameTF.text, email: emailText, password: passwordText)
            let storyboard = UIStoryboard(name: "SecretCodeStoryboard", bundle: nil)
            if let secretCodeVC = storyboard.instantiateViewController(withIdentifier: "SecretCodeViewController") as? SecretCodeViewController {
                navigationController?.pushViewController(secretCodeVC, animated: true)
                secretCodeVC.userModel = userModel
            }
        }
    }
    
    // MARK: - Private functions
    private func setupUI() {
        continueBtn.layer.cornerRadius = continueBtn.frame.size.height / 2
    }
    
    private func updateContinueBtnState() {
        continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak
    }
    
    private func setUpPasswordIndicators() {
        for (index, view) in strongPassIndicatorsViews.enumerated() {
            if index <= (passwordStrength.rawValue - 1) {
                view.alpha = 0.7
            } else {
                view.alpha = 0.2
            }
        }
        //        strongPassIndicatorsViews.enumerated().forEach { index, view in
        //            if index <= (passwordStrength.rawValue - 1) {
        //                view.alpha = 1
        //            } else {
        //                view.alpha = 0.2
        //            }
        //        }
    }
    
    /// Keyboard Observer-s
    // поднятие ScrollView
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
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
