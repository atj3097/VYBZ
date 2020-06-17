//
//  OnboardingViewController.swift
//  Vybz
//
//  Created by God on 3/21/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import paper_onboarding
class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    
    @IBAction func leaveOnboarding(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = storyboard.instantiateViewController(identifier: VCIds.VybzTabVC.rawValue) as! VybzTabVC
        show(tabBar, sender: self)
    }
    fileprivate let items = [
    OnboardingItemInfo(informationImage: Asset.hotels.image,
                       title: "Welcome To VYBZ",
                       description: "A new way to make music. This is a tool to translate your emotions into music.",
                       pageIcon: Asset.circle.image,
                       color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                       titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    
    OnboardingItemInfo(informationImage: Asset.banks.image,
                       title: "The Mood Music Algorithim",
                       description: "Based on our algorithim we give you the proper scales and chord progressions that will fit the emotion you want to write your song in.",
                       pageIcon: Asset.circle.image,
                       color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                       titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    
    OnboardingItemInfo(informationImage: Asset.stores.image,
                       title: "Learn",
                       description: "Expand your knowledge of music theory.",
                       pageIcon: Asset.circle.image,
                       color: UIColor(red: 0.61, green: 0.56, blue: 0.74, alpha: 1.00),
                       titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont),
    
    ]

        override func viewDidLoad() {
            super.viewDidLoad()
//            skipButton.isHidden = false
            setupPaperOnboardingView()
            view.bringSubviewToFront(skipButton)
        }

        private func setupPaperOnboardingView() {
            let onboarding = PaperOnboarding()
            onboarding.delegate = self
            onboarding.dataSource = self
            onboarding.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(onboarding)

            // Add constraints
            for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
                let constraint = NSLayoutConstraint(item: onboarding,
                                                    attribute: attribute,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: attribute,
                                                    multiplier: 1,
                                                    constant: 0)
                view.addConstraint(constraint)
            }
        }
    }

    // MARK: Actions

    extension OnboardingViewController {

    }

    // MARK: PaperOnboardingDelegate

    extension OnboardingViewController: PaperOnboardingDelegate {

        func onboardingWillTransitonToIndex(_ index: Int) {
        }

        func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
            
            // configure item
            
            //item.titleLabel?.backgroundColor = .redColor()
            //item.descriptionLabel?.backgroundColor = .redColor()
            //item.imageView = ...
        }
    }

    // MARK: PaperOnboardingDataSource

    extension OnboardingViewController: PaperOnboardingDataSource {

        func onboardingItem(at index: Int) -> OnboardingItemInfo {
            return items[index]
        }

        func onboardingItemsCount() -> Int {
            return 3
        }
        
    }


    //MARK: Constants
    private extension OnboardingViewController {
        static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
        static let descriptionFont = UIFont(name: "OpenSans-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
    }
