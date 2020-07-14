//
//  ScaleViewController.swift
//  Vybz
//
//  Created by God on 6/17/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import AnimatedCollectionViewLayout

private let reuseIdentifier = CellIds.keyCell.rawValue


class KeyViewController: UICollectionViewController {
    
    lazy var titleForTutorial: UILabel = {
        let label = UILabel()
        label.text = "1) Choose The Key"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Bold", size: 32.0) ?? UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    lazy var labelForTutorial: UILabel = {
        let label = UILabel()
        label.text = "Now choose what key you want your song to be in!"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Bold", size: 32.0) ?? UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    lazy var popupView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var dismissPopUp: UIButton = {
        let button = UIButton()
        button.setTitle("Ok!", for: .normal)
        button.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        return button
    }()
    
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
        view.addSubview(popupView)
                   popupView.addSubview(titleForTutorial)
                   popupView.addSubview(labelForTutorial)
                   
                   popupView.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       popupView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.2),
                       popupView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.2),
                       popupView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                       popupView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                   ])
                   
                   popupView.layer.shadowColor = UIColor(red: 35/255, green: 46/255, blue: 33/255, alpha: 1).cgColor
                   popupView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                   popupView.layer.shadowOpacity = 0.9
                   popupView.layer.shadowRadius = 4
                   
                   var color = "009688"
                   popupView.backgroundColor = color.hexColor
                   labelForTutorial.translatesAutoresizingMaskIntoConstraints = false
                   
                   titleForTutorial.translatesAutoresizingMaskIntoConstraints = false
                   NSLayoutConstraint.activate([
                       titleForTutorial.topAnchor.constraint(equalTo: popupView.topAnchor,constant: 3),
                       titleForTutorial.leftAnchor.constraint(equalTo: popupView.leftAnchor)
                   ])
                   
                   NSLayoutConstraint.activate([
                       labelForTutorial.topAnchor.constraint(equalTo: titleForTutorial.bottomAnchor, constant: 35),
                       labelForTutorial.leftAnchor.constraint(equalTo: popupView.leftAnchor),
                       labelForTutorial.rightAnchor.constraint(equalTo: popupView.rightAnchor)
                   ])
                   popupView.addSubview(dismissPopUp)
                   dismissPopUp.translatesAutoresizingMaskIntoConstraints = false
                   
                   NSLayoutConstraint.activate([
                       dismissPopUp.bottomAnchor.constraint(equalTo: popupView.bottomAnchor),
                       dismissPopUp.leftAnchor.constraint(equalTo: popupView.leftAnchor),
                       dismissPopUp.rightAnchor.constraint(equalTo: popupView.rightAnchor)
                   ])
        
        
        
        collectionView.backgroundColor = .white
        self.navigationItem.title = ""
         collectionView?.isPagingEnabled = true
               let layout = AnimatedCollectionViewLayout()
               layout.animator = CubeAttributesAnimator()
               collectionView.collectionViewLayout = layout
        self.navigationItem.title = moodString?.capitalizingFirstLetter()
    }
    
    @objc func dismissPopup() {
           popupView.isHidden = true
       }
    
    private func setBackgroundColor(moodName: String) -> UIColor {
        var background = UIColor()
        switch moodName.lowercased() {
        case Moods.happy.rawValue:
            background = MoodColors.happy
        case Moods.chill.rawValue:
            background = MoodColors.chill
        case Moods.dark.rawValue:
            background = MoodColors.dark
        case Moods.spacy.rawValue:
            background = MoodColors.spacy
        case Moods.bright.rawValue:
            background = MoodColors.bright
        case Moods.love.rawValue:
            background = MoodColors.love
        case Moods.soul.rawValue:
            background = MoodColors.soul
        case Moods.island.rawValue:
            background = MoodColors.island
        case Moods.exotic.rawValue:
            background = MoodColors.exotic
        default:
            print("no mood")
        }
        return background
    }

 
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = setBackgroundColor(moodName: moodString ?? "")
          if let cell = cell as? KeyCell {
                  let i = indexPath.row % vcs.count
                  cell.clipsToBounds = animator?.1 ?? true
                  cell.keyLabel.text = "\(chromaticScale.keys[indexPath.row])"
              }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Onboard", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        mood = Mood.moodCreator(name: moodString!, key: chromaticScale.keys[indexPath.row])
        chosenKey = chromaticScale.keys[indexPath.row]
        var viewController = storyBoard.instantiateViewController(withIdentifier: "ScaleOnboard") as? ScaleViewController
        viewController!.chosenMood = mood
        viewController?.title = moodString?.capitalizingFirstLetter()
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }



}
extension KeyViewController: UICollectionViewDelegateFlowLayout {
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
