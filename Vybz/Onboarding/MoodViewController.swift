//
//  MoodViewController.swift
//  Vybz
//
//  Created by God on 6/17/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class MoodViewController: UICollectionViewController {
    
    lazy var titleForTutorial: UILabel = {
        let label = UILabel()
        label.text = "1) Choose Your Mood"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Bold", size: 32.0) ?? UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    lazy var labelForTutorial: UILabel = {
        let label = UILabel()
        label.text = "The first step in the process is to choose your mood. Scroll through the list of moods provided and play the song example. "
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Bold", size: 20.0) ?? UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var popupView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var dismissPopUp: UIButton = {
        let button = UIButton()
        button.setTitle("I'm Ready!", for: .normal)
        button.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        return button
    }()

    private let reuseIdentifier = CellIds.moodCell.rawValue
        private var moods = ["Happy", "Chill", "Dark", "Spacy", "Bright", "Love", "Soul", "Island", "Exotic"]
        var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
        var direction: UICollectionView.ScrollDirection = .vertical
        var moodString: String?
    
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
            
            var color = "03aaf4"
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
            
            self.navigationController?.navigationBar.isHidden = true
            let layout = AnimatedCollectionViewLayout()
            layout.animator = ParallaxAttributesAnimator()
            collectionView.collectionViewLayout = layout
    //        collectionView.backgroundView?.setGradientBackground(color1: UIColor.yellow.cgColor, color2: UIColor.green.cgColor)
            self.navigationItem.title = ""
                self.navigationController!.navigationBar.barStyle = .default
            self.navigationController!.navigationBar.isTranslucent = true
            self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    
    @objc func dismissPopup() {
        popupView.isHidden = true
    }
        
        // MARK: UICollectionViewDataSource
        
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
     
            return 1
        }
        
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return 9
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let c = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            if let cell = c as? MoodCell {
                let i = indexPath.row % vcs.count
                let v = vcs[i]
                cell.bind(color: v.0, imageName: v.1)
                cell.clipsToBounds = animator?.1 ?? true
                cell.moodLabel.text = moods[indexPath.row]
                switch indexPath.row {
                case 0:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-happy-64")
                    cell.moodDescription.text = "Dopamine overload."
                    cell.assetName = "Happy"
                    cell.nowPlaying.text = "Inspiration: Happy by Pharrell"
                    cell.gifName = "sponge"
                case 1:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-yoga-96 (2)")
                    cell.moodDescription.text = "The sounds of relaxation."
                    cell.assetName = "Sativa"
                    cell.nowPlaying.text = "Inspiration: Sativa by Jhene Aiko"
                    cell.gifName = "chill"
                case 2:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-film-noir-96")
                    cell.moodDescription.text = "Midnight music."
                    cell.assetName = "Drake"
                    cell.nowPlaying.text = "Inspiration: Money In The Grave by Drake"
                    cell.gifName = "dark"
                case 3:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-sci-fi-80")
                    cell.moodDescription.text = "Feeling out of this world."
                    cell.assetName = "Travis"
                    cell.nowPlaying.text = "Inspiration: Highest In The Room by Travis Scott"
                    cell.gifName = "space"
                case 4:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-sun-128")
                    cell.moodDescription.text = "Songs For The Summer."
                    cell.assetName = "Lorde"
                    cell.nowPlaying.text = "Inspiration: Green Light by Lorde"
                    cell.gifName = "bright"
                case 5:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-love-96")
                    cell.moodDescription.text = "Falling In Or Falling Out Of Love."
                    cell.assetName = "SZA"
                    cell.nowPlaying.text = "Inspiration: The Weekend by SZA"
                    cell.gifName = "simp"
                case 6:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-saxophone-96")
                    cell.moodDescription.text = "Self Care Vibes."
                    cell.assetName = "Solo"
                    cell.nowPlaying.text = "Inspiration: Way To The Show by Solange"
                    cell.gifName = "soul"
                case 7:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-palm-tree-96")
                    cell.moodDescription.text = "Toes In The Sand"
                    cell.assetName = "WSTRN"
                    cell.nowPlaying.text = "Inspiration: Ben Ova by WSTRN"
                    cell.gifName = "trip"
                case 8:
                    cell.moodIcon.image = #imageLiteral(resourceName: "icons8-flamenco-96")
                    cell.moodDescription.text = "Spice It Up"
                    cell.assetName = "Rosa"
                    cell.nowPlaying.text = "Inspiration: Malamente By Rosalia"
                    cell.gifName = "squid"
                default:
                    print("")
                }
            }
            
            moodColor = c.contentView.backgroundColor!
            return c
        }
        
        // MARK: UICollectionViewDelegate
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let backItem = UIBarButtonItem()
            backItem.title = ""
            moodString = moods[indexPath.row].lowercased()
            let storyBoard = UIStoryboard(name: "Onboard", bundle: nil)
            if let viewController = storyBoard.instantiateViewController(withIdentifier: "OnboardKeys2") as? KeyViewController {
                viewController.moodString = self.moodString
                viewController.title = moodString?.capitalizingFirstLetter()
                viewController.navigationItem.backBarButtonItem = backItem
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
    }
    extension MoodViewController: UICollectionViewDelegateFlowLayout {
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
