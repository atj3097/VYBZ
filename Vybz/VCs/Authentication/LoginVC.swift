//
//  LoginVC.swift
//  Vybz
//
//  Created by God on 12/12/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation
import AVKit
import TextFieldEffects
class LoginVC: UIViewController {
    private var animator: UIViewPropertyAnimator!
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!

    @IBOutlet weak var loginGif: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var vybzLogo: UIImageView!
    @IBAction func signIn(_ sender: UIButton) {
        
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
               
               FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
                   self.handleLoginResponse(with: result)
               }
    }
    override func viewWillAppear(_ animated: Bool) {
            animateLogo()
            loginGif.image = UIImage.gif(asset: "metro")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = .black
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        loginGif.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        navigationController?.navigationBar.isHidden = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
//        playSplashVid()
        animateLogo()
        signInButton.roundButton(button: signInButton)
    }
    
    func playSplashVid() {
        let theURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/test-1a5af.appspot.com/o/metro-boomin-presents-good-cook-up-vol-1.mp4?alt=media&token=f275f69b-c5aa-4731-8c58-d71b2e84b791")
        avPlayer = AVPlayer(url: theURL!)
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayer.volume = 0
        avPlayer.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        avPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = UIColor.clear
        view.layer.insertSublayer(avPlayerLayer, at: 0)
      DispatchQueue.global(qos: .background).async {
        DispatchQueue.main.async {
            self.avPlayer.play()
          }
      }
    }
    
    func animateLogo() {
        UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .curveEaseInOut,.autoreverse], animations: {
            self.vybzLogo.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
        })
    }
    

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
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
extension UITextField {
  func setGradient() {
            let gradient = CAGradientLayer()
            gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
            gradient.startPoint = CGPoint(x:0.0, y:0.5)
            gradient.endPoint = CGPoint(x:1.0, y:0.5)
            gradient.colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor]
    self.layer.addSublayer(gradient)
  }

}
extension UIView {
    
    func setGradientBackground(color1: CGColor, color2: CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.0, 0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

struct Colors {
    
    static let brightOrange     = UIColor(red: 255.0/255.0, green: 69.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let red              = UIColor(red: 255.0/255.0, green: 115.0/255.0, blue: 115.0/255.0, alpha: 1.0)
    static let orange           = UIColor(red: 255.0/255.0, green: 175.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    static let blue             = UIColor(red: 74.0/255.0, green: 144.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    static let green            = UIColor(red: 91.0/255.0, green: 197.0/255.0, blue: 159.0/255.0, alpha: 1.0)
    static let darkGrey         = UIColor(red: 85.0/255.0, green: 85.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    static let veryDarkGrey     = UIColor(red: 13.0/255.0, green: 13.0/255.0, blue: 13.0/255.0, alpha: 1.0)
    static let lightGrey        = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
    static let black            = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    static let white            = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
}
