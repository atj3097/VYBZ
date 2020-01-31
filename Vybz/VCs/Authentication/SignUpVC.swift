//
//  SignUpVC.swift
//  Vybz
//
//  Created by God on 12/12/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import FirebaseAuth
class SignUpVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpGif: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpFunc: UIButton!
    @IBOutlet weak var log: UIImageView!

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
        
            FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
                self?.handleCreateAccountResponse(with: result)
            }
            
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpGif.image = UIImage.gif(asset: "metro")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let user):
                
                //MARK: TODO - move this logic to the server
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
                let vybzTab = storyboard.instantiateViewController(identifier: VCIds.VybzTabVC.rawValue) as! VybzTabVC
                sceneDelegate.window?.rootViewController = vybzTab
            }, completion: nil)
        case .failure(let error):
            self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
        }
    }
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    

}
