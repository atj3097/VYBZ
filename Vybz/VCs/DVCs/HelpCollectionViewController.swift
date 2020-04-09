//
//  HelpCollectionViewController.swift
//  Vybz
//
//  Created by God on 3/23/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

private let reuseIdentifier = CellIds.helpCell.rawValue
struct Paragraphs {
    static var scaleParagraph = "Over thousands of years humans have noticed patterns in the different sequences that we play the 12 notes on the piano. These different sequences of notes are called scales. There are tons of different scales each one having their own usage. For example a minor scale can make you sad. While a major scale can make you happy! Or the phyrgian scale is super dark and mean!"
    static var chordParagraph = "The right chord progression can make or break your song. Your chord progression will be the foundation of your song. Use the chord progressions we give you and play them in different patterns to get different inspiration."
    static var songwritingParagraph = "Songwriting is one of the greatest artforms. There's an infinite amount of ways to write a song. Our app is a big help with that. Using our help, choose a mood and create a melody from the scale that we give you(all the highlighted keys). After that play a chord progression underneath this melody, add some drums and boom! You have a song!"
}

class HelpCollectionViewController: UICollectionViewController {
    
    var tips = [Help(title: "Scales Are The Building Blocks of Music", moreInformation: Paragraphs.scaleParagraph, exampleGif: nil), Help(title: "Chords", moreInformation: Paragraphs.chordParagraph, exampleGif: nil), Help(title: "Song", moreInformation: Paragraphs.songwritingParagraph, exampleGif: nil)]
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
//        collectionView.register(HelpCell.self, forCellWithReuseIdentifier: reuseIdentifier)
//
//         self.navigationController?.navigationBar.isHidden = true
                let layout = AnimatedCollectionViewLayout()
                layout.animator = ParallaxAttributesAnimator()
        
                collectionView.collectionViewLayout = layout
        //        collectionView.backgroundView?.setGradientBackground(color1: UIColor.yellow.cgColor, color2: UIColor.green.cgColor)
//                self.navigationItem.title = ""
//                    self.navigationController!.navigationBar.barStyle = .default
//                self.navigationController!.navigationBar.isTranslucent = true
//                self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return tips.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HelpCell
        cell.currentTip = tips[indexPath.row]
        cell.helpTitle.text = tips[indexPath.row].title
        cell.helpParahraph.text = tips[indexPath.row].moreInformation
        cell.helpGif.image = UIImage.gif(asset: "demo")
        let i = indexPath.row % vcs.count
        let v = vcs[i]
        cell.bind(color: v.0, imageName: v.1)
        cell.clipsToBounds = animator?.1 ?? true
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
extension HelpCollectionViewController: UICollectionViewDelegateFlowLayout {
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

