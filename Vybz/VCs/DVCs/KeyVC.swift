//
//  KeyVC.swift
//  Vybz
//
//  Created by God on 12/10/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import AnimatedCollectionViewLayout

private let reuseIdentifier = CellIds.keyCell.rawValue
public var chromaticScale = Scale(type: .chromatic, key: Key(type: .c, accidental: .natural))

class KeyVC: UICollectionViewController {
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
       var direction: UICollectionView.ScrollDirection = .vertical
    var moodString: String?
    var chosenKey: Key?
    var scale: Scale?
    var pitch: Pitch?
    var mood: Mood?
    var moodEnum: Moods?
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
        collectionView.backgroundColor = .white
        self.navigationItem.title = ""
         collectionView?.isPagingEnabled = true
               let layout = AnimatedCollectionViewLayout()
               layout.animator = CubeAttributesAnimator()
               collectionView.collectionViewLayout = layout
        self.navigationItem.title = moodString?.capitalizingFirstLetter()
        // Do any additional setup after loading the view.
    }

 
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = moodColor
          if let cell = cell as? KeyCell {
                  let i = indexPath.row % vcs.count
           
//                  let v = vcs[0]
//                  cell.bind(color: v.0, imageName: v.1)
//
                  cell.clipsToBounds = animator?.1 ?? true
                  cell.keyLabel.text = "\(chromaticScale.keys[indexPath.row])"
              }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        mood = Mood.moodCreator(name: moodString!, key: chromaticScale.keys[indexPath.row])
        chosenKey = chromaticScale.keys[indexPath.row]
        var viewController = storyBoard.instantiateViewController(withIdentifier: DVCIds.PianoScaleVC.rawValue) as? ScaleVC
        viewController!.chosenMood = mood
        viewController?.title = moodString?.capitalizingFirstLetter()
        
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }



}
extension KeyVC: UICollectionViewDelegateFlowLayout {
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
