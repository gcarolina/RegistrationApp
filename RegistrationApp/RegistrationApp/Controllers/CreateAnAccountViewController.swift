//  CreateAnAccountViewController.swift
//  RegistrationApp
//  Created by Carolina on 18.11.22.

import UIKit

final class CreateAnAccountViewController: UIViewController {
    var nameOfPerson = ""
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
    }
    
    // MARK: - Properties
    private var isValidEmail = false { didSet { updateContinueBtnState() }}
    private var isConfPass = false { didSet { updateContinueBtnState() }}
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() }}
    
    
    // MARK: - Actions
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
               !email.isEmpty,
               VerificationServices.isValidEmail(email: email) {
                    isValidEmail = true
                } else {
                    isValidEmail = false
                }
        errorEmailLbl.isHidden = isValidEmail
    }

    @IBAction func passwTFAction(_ sender: UITextField) {
        if let passText = sender.text, !passText.isEmpty {
            passwordStrength = VerificationServices.isValidPassword(pass: passText)
        } else {
            passwordStrength = .veryWeak
        }
        errorPasswordLbl.isHidden = passwordStrength != .veryWeak
        setUpPasswordIndicators()
    }
    
    // переход по конпке SignIn из WelcomeVC в SignInVC
    @IBAction func signInAction() {
        performSegue(withIdentifier: "unwindToSignInVC", sender: "")
    }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
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
    @IBAction func continueAction() {
        let storyboard = UIStoryboard(name: "SecretCodeStoryboard", bundle: nil)
        if let secretCodeVC = storyboard.instantiateViewController(withIdentifier: "SecretCodeViewController") as? SecretCodeViewController {
            navigationController?.pushViewController(secretCodeVC, animated: true)
            secretCodeVC.email = emailTF.text
            secretCodeVC.nameOfPearson = nameTF.text
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
    
    
    // поднятие ScrollView
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }


    // MARK: - Keyboard Delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc func keyboardWillShow(notification:NSNotification){

        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification){

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInset
    }
}
