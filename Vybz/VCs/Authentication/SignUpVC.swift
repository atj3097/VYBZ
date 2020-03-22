//
//  SignUpVC.swift
//  Vybz
//
//  Created by God on 12/12/19.
//  Copyright © 2019 God. All rights reserved.
//MARK: Make Gif Full Screens

import UIKit
import FirebaseAuth
import TextFieldEffects
class SignUpVC: UIViewController {
    private enum SignInMethod {
        case logIn
        case register
    }
    private var signInMethod: SignInMethod = .logIn
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signUpFunc.setTitle("Login", for: .normal)
            signInMethod = .logIn
        } else {
            signUpFunc.setTitle("Sign Up", for: .normal)
            signInMethod = .register
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpGif: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpFunc: UIButton!
    @IBOutlet weak var log: UIImageView!
    
    @IBOutlet weak var alreadyHaveAnAcoount: UIButton!
    @IBAction func signUp(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                showAlert(with: "Error", and: "Please fill out all fields.")
                return
            }
            
            guard email.isValidEmail else {
                showAlert(with: "Error", and: "Please enter a valid email")
                return
            }
            
            guard password.isValidPassword else {
                showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
                return
            }
            switch signInMethod {
            case .logIn:
            FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
                self.handleLoginAccountResponse(with: result)
            }
            case .register:
                FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password, completion: {(result) in
                    self.handleCreateAccountResponse(with: result)
                })
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        animateLogo()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .black
        signUpGif.image = UIImage.gif(asset: "metro")
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        signUpGif.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        signUpFunc.roundButton(button: signUpFunc)
        emailTextField.textColor = .black
        emailTextField.backgroundColor = .white
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = .white
       emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter Email",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.50)])
       passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.50)])
        dismissKeyboardWithTap()
    }
    
    private func dismissKeyboardWithTap() {
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
      view.endEditing(true)
    }
    func animateLogo() {
        UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .curveEaseInOut,.autoreverse], animations: {
            self.log.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        })
    }
    
    //MARK: Completion Handlers
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let user):
                
                FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                    self?.handleCreatedUserInFirestore(result: newResult)
                }
            case .failure(let error):
                self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
            }
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<Void, Error>) {
        switch result {
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                else {
                    self.dismiss(animated: true, completion: nil)
                    return
            }
            
            UIView.transition(with: self.view, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let onbardingVC = storyboard.instantiateViewController(identifier: VCIds.OnboardingVC.rawValue) as! OnboardingViewController
                sceneDelegate.window?.rootViewController = onbardingVC
            }, completion: nil)
        case .failure(let error):
            self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
        }
    }
        
        func handleLoginAccountResponse(with result: Result<(), Error>) {
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self.showAlert(with: "Error", and: "Could not log in. Error: \(error)")
                case .success:
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                        let sceneDelegate = windowScene.delegate as? SceneDelegate
                        else {
                            return
                    }
                    UIView.transition(with: self.view, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
                      let moodPage = storyboard.instantiateViewController(identifier: VCIds.VybzTabVC.rawValue) as! VybzTabVC
                      sceneDelegate.window?.rootViewController = moodPage
                    }, completion: nil)
                }
            }
        }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
