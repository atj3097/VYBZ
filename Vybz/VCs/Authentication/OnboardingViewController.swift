//
//  OnboardingViewController.swift
//  Vybz
//
//  Created by God on 2/21/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout
class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    var onboardingInfomation = [0: ("Welcome",#imageLiteral(resourceName: "icons8-love-96"), "The mission of the VYBZ team is to bring you one of the most helpful tools for you as a music creator"), 1: ("Mood Music",UIImage.gif(asset: "demo"),"Using our 'Mood Music' algorithim we will give you the scales and chord progression that will allow you to wrtie a song in whatever mood you want to create in")]
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingCollectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        onboardingCollectionView.collectionViewLayout = layout
        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
    }
}
extension OnboardingViewController: UICollectionViewDelegate {
    
}
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboardingInfomation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = onboardingCollectionView.dequeueReusableCell(withReuseIdentifier: "onboardCell", for: indexPath) as? OnboardingCell else {return UICollectionViewCell()}
        let currentImage = onboardingInfomation[indexPath.row]?.1
        let currentTitle = onboardingInfomation[indexPath.row]?.0
        let description = onboardingInfomation[indexPath.row]?.2
        cell.onboardingIcon.image = currentImage
        cell.onboardingTitle.text = currentTitle
        cell.onboardingDesc.text = description
        cell.backgroundColor = .white
        return cell
    }
    
    
}
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       guard let animator = animator else { return view.bounds.size }
       return CGSize(width: view.bounds.width / CGFloat(animator.2), height: view.bounds.height / CGFloat(animator.3))
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return .zero
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       return 0
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
   }
}
