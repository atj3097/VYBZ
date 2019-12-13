//
//  EducationVC.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import GLNPianoView
import AnimatedCollectionViewLayout

private let reuseIdentifier = CellIds.edCell.rawValue
private var ed = ["Scales", "Chords", "How To Use The App", "Help"]
class EducationVC: UICollectionViewController {
    
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    var direction: UICollectionView.ScrollDirection = .vertical
    
    let vcs = [("f44336", "nature1"),
               ("9c27b0", "nature2"),
               ("3f51b5", "nature3"),
               ("03a9f4", "animal1"),
               ("009688", "animal2"),
               ("8bc34a", "animal3"),
               ("FFEB3B", "nature1"),
               ("FF9800", "nature2"),
               ("795548", "nature3"),
               ("607D8B", "animal1")]

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.isPagingEnabled = true
        let layout = AnimatedCollectionViewLayout()
        layout.animator = CubeAttributesAnimator()
        collectionView.collectionViewLayout = layout
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
 
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let c = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let cell = c as? EducationCell {
            let i = indexPath.row % vcs.count
            let v = vcs[i]
            cell.bind(color: v.0, imageName: v.1)
            cell.clipsToBounds = animator?.1 ?? true
            cell.edLabel.text = ed[indexPath.row]
        }
        return c
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyBoard.instantiateViewController(withIdentifier: DVCIds.KeyVC.rawValue) as? KeyVC {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
extension EducationVC: UICollectionViewDelegateFlowLayout {
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
