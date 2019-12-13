//
//  LoginVC.swift
//  Vybz
//
//  Created by God on 12/12/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController {
    private var animator: UIViewPropertyAnimator!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var vybzLogo: UIImageView!
    
    @IBAction func signIn(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
                   showAlert(with: "Error", and: "Please fill out all fields.")
                   return
               }
               
               //MARK: TODO - remove whitespace (if any) from email/password
               
               guard email.isValidEmail else {
                   showAlert(with: "Error", and: "Please enter a valid email")
                   return
               }
               
               guard password.isValidPassword else {
                   showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
                   return
               }
               
               FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
                   self.handleLoginResponse(with: result)
               }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
    private func handleLoginResponse(with result: Result<(), Error>) {
          switch result {
          case .failure(let error):
              showAlert(with: "Error", and: "Could not log in. Error: \(error)")
          case .success:
              guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let sceneDelegate = windowScene.delegate as? SceneDelegate
                  else {
                      return
              }
              UIView.transition(with: self.view, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vybzTab = storyboard.instantiateViewController(identifier: VCIds.VybzTabVC.rawValue) as! VybzTabVC
                  sceneDelegate.window?.rootViewController = vybzTab
              }, completion: nil)
          }
      }
    private func showAlert(with title: String, and message: String) {
           let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
           present(alertVC, animated: true, completion: nil)
       }

}
