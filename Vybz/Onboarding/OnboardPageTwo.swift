//
//  OnboardPageTwo.swift
//  Vybz
//
//  Created by God on 6/17/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit

class OnboardPageTwo: UIViewController {
    lazy var appLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "icons8-piano-64 (1)")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "The Mood Music Algorithim"
        label.textColor = .white
        label.font = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        return label
    }()
    
    lazy var textView: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        text.text = "Based on our algorithim we give you the proper scales and chord progressions that will fit the emotion you want to write your song in."
        text.textColor = .white
        text.textAlignment = .center
        text.font = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 20.0)
        return text
    }()
    
    lazy var startTutorialButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(startTutorial), for: .touchUpInside)
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        addSubViews()
        setUIConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var color = "9c27b0"
        view.backgroundColor = color.hexColor
    }
    
    @objc private func startTutorial() {
        let pageThree = OnboardPageThree()
        pageThree.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(pageThree, animated: true)
    }
    
    private func addSubViews() {
        view.addSubview(appLogo)
        view.addSubview(titleLabel)
        view.addSubview(textView)
        view.addSubview(startTutorialButton)
    }
    
    private func setUIConstraints() {
        appLogo.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        startTutorialButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            appLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogo.heightAnchor.constraint(equalToConstant: 100),
            appLogo.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: appLogo.bottomAnchor,constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: appLogo.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 30),
            textView.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            startTutorialButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            startTutorialButton.centerXAnchor.constraint(equalTo: textView.centerXAnchor),
            startTutorialButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            startTutorialButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            startTutorialButton.heightAnchor.constraint(equalToConstant: view.frame.height / 5.5)
        ])
    }

}
