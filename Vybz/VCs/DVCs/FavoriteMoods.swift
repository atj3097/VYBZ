//
//  FavoriteMoods.swift
//  Vybz
//
//  Created by God on 1/18/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import Firebase
private let reuseIdentifier = "favCell"

class FavoriteMoods: UICollectionViewController {
    var user: AppUser!
    var moods = [FaveMood]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        user = AppUser(from: FirebaseAuthService.manager.currentUser!)
        getFavorties()
        print(moods.count)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        user = AppUser(from: FirebaseAuthService.manager.currentUser!)
////        print(user.uid)
//        getFavorties()
//        print(moods.count)
//        guard moods.count != 0 else {
//            showAlert(with: "No Moods saved!", and: "Save some moods in the moods tab")
//            return
//        }
//        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    func getFavorties() {
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
        FirestoreService.manager.getFavs(forUserID: user.uid ) { (result) in
                
                switch result {
                case .success(let favMoods):
                    
                    self.moods = favMoods
                    
                case .failure(let error):
                    
                    print(":( \(error)")
                }
            }
    }
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(alert: UIAlertAction!) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = storyboard.instantiateViewController(withIdentifier: VCIds.VybzTabVC.rawValue) as! VybzTabVC
            self.present(tabBar, animated: true, completion: nil)
        }))
        present(alertVC, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moods.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FaveMoodCell
        let currentMood = moods[indexPath.row]
        cell?.moodName.text = currentMood.moodName
        cell?.moodKey.text = currentMood.moodKey
        cell?.moodScale.text = currentMood.scale.description
        cell?.chordProgression.text = currentMood.chordProgression1.description
        cell?.moodImage.image = #imageLiteral(resourceName: "icons8-happy-96")
        return cell!
    }
    
}
