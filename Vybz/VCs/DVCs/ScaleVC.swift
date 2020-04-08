//
//  ScaleVC.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.

import UIKit
import MusicTheorySwift
import GLNPianoView
import Firebase
import FirebaseAuth


public var moodColor = UIColor()

class ScaleVC: UIViewController, GLNPianoViewDelegate {
    
    private let audioEngine = AudioEngine()
    let keyboardFunctions = KeyboardFunctions()
    var chosenMood: Mood?
    var moodString: String?
    var chosenKey: Key?
    var firebaseChord1: [String]?
    var firebaseChord2: [String]?
    var firebaseChord3: [String]?
    var firebaseChord4: [String]?
    var firebaseScale: [String]?
    
    @IBOutlet weak var keyboard: GLNPianoView!
    @IBOutlet weak var scaleButton: UIButton!
    @IBOutlet weak var chordButton: UIButton!
    @IBOutlet weak var noteSwitch: UISwitch!
    @IBOutlet weak var fascia: UIView!
    @IBOutlet weak var likebutton: UIButton!
    
    @IBAction func saveMood(_ sender: UIButton) {
        saveMood()
    }
    
    @IBAction func showNotes(_ sender: UISwitch) {
        keyboard.toggleShowNotes()
    }
    
    @IBOutlet var chordButtons: [UIButton]!
    
    @IBAction func playAll(_ sender: UIButton) {
        keyboardFunctions.playAllChords(currentChordProgression: chosenMood?.moodChordprogressions, keyboard: keyboard)
    }
    
    @IBAction func showChordNames(_ sender: UIButton) {
        chordButtons.forEach({$0.isHidden = false})
    }
    
    @IBAction func playChord(_ sender: UIButton) {
        keyboardFunctions.playChordSender(tag: sender.tag, currentChordProgression: chosenMood?.moodChordprogressions, keyboard: keyboard)
    }
    @IBAction func showScale(_ sender: UIButton) {
        keyboardFunctions.highlightScale(currentScale: chosenMood!.moodScale, keyboard: keyboard)
        
    }
    
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        setGradientLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboard.delegate = self
        audioEngine.start()
        customizeKeyboardElements()
        setUpChordButtons()
        likebutton.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
    }
    
    func pianoKeyDown(_ keyNumber: Int) {
        audioEngine.sampler.startNote(UInt8(keyboard.octave + keyNumber), withVelocity: 64, onChannel: 0)
    }
    
    func pianoKeyUp(_ keyNumber: Int) {
        audioEngine.sampler.stopNote(UInt8(keyboard.octave + keyNumber), onChannel: 0)
    }
    
    //MARK: Private methods
    private func handlePostResponse(withResult result: Result<Void, Error>) {
        switch result {
        case .success:
            let alertVC = UIAlertController(title: "", message: "Added to your favorites", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { [weak self] (action)  in
                DispatchQueue.main.async {
                    self?.navigationController?.popViewController(animated: true)
                }
            }))
            
            present(alertVC, animated: true, completion: nil)
        case let .failure(error):
            print("An error occurred creating the post: \(error)")
        }
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //MARK: Helper Functions
    @objc func saveMood() {
        let allChords = [chosenMood?.moodChordprogressions[0],chosenMood?.moodChordprogressions[1],chosenMood?.moodChordprogressions[2],chosenMood?.moodChordprogressions[3]]
        var noteCharacters = [[String]]()
        for chord in allChords {
            let chordString = (chord?.keys.chordToString(notes: chord!.keys, octave: 4))!
            noteCharacters.append(chordString)
        }
        firebaseScale = chosenMood?.moodScale.keys.scaleToString(notes: (chosenMood?.moodScale.keys)!, octave: 4)
        firebaseChord1 = noteCharacters[0]
        firebaseChord2 = noteCharacters[1]
        firebaseChord3 = noteCharacters[2]
        firebaseChord4 = noteCharacters[3]
        
        guard let moodName = chosenMood?.moodName, let key = chosenMood?.moodKey.description, let userId = Auth.auth().currentUser?.uid, let chord1 = firebaseChord1, let chord2 = firebaseChord2, let chord3 = firebaseChord3, let chord4 = firebaseChord4, let scale = firebaseScale else {
            showAlert(with: "Oops!", and: "Play the chord Progression and tap the Scale button before you save this mood!")
            return
        }
        
        
        let fav = FaveMood(name: moodName, key: key, userID: userId, chordProgression1: chord1, chordProgression2: chord2, chordprogression3: chord3, chordProgression4: chord4, scale: scale)
        FirestoreService.manager.addFavorite(favs: fav) { (result) in
            self.handlePostResponse(withResult: result)
        }
    }
    
    func setUpChordButtons() {
        chordButtons[0].setTitle(chosenMood?.moodChordprogressions[0]?.description, for: .normal)
        chordButtons[1].setTitle(chosenMood?.moodChordprogressions[1]?.description, for: .normal)
        chordButtons[2].setTitle(chosenMood?.moodChordprogressions[2]?.description, for: .normal)
        chordButtons[3].setTitle(chosenMood?.moodChordprogressions[3]?.description, for: .normal)
    }
    
    //MARK: UI Functions
    func setGradientLayer() {
        let layer = CAGradientLayer()
        layer.frame = fascia.bounds
        layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
        layer.startPoint = CGPoint(x: 0.0, y: 0.80)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        fascia.layer.insertSublayer(layer, at: 0)
    }
    
    func customizeKeyboardElements() {
        scaleButton.roundButton(button: scaleButton)
        chordButton.roundButton(button: chordButton)
        scaleButton.backgroundColor = moodColor
        chordButton.backgroundColor = moodColor
        noteSwitch.onTintColor = moodColor
        chordButtons.forEach({$0.isHidden = true})
    }
    
}



