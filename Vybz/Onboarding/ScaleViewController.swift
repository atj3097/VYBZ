//
//  ScaleViewController.swift
//  Vybz
//
//  Created by God on 6/19/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import GLNPianoView
import Firebase
import FirebaseAuth



class ScaleViewController: UIViewController, GLNPianoViewDelegate {
    
    lazy var titleForTutorial: UILabel = {
        let label = UILabel()
        label.text = "3) You're All Set!"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Nunito-Bold", size: 32.0) ?? UIFont.boldSystemFont(ofSize: 32.0)
        return label
    }()
    
    lazy var labelForTutorial: UILabel = {
        let label = UILabel()
        label.text = "You now have a scale and chord progression to write your song to! Try it out!"
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
        button.setTitle("Lets Go!", for: .normal)
        button.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        return button
    }()
    
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
    
    @IBOutlet weak var finishtutorialButton: UIButton!
    @IBAction func finishtutorialButton(_ sender: Any) {
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                else {
                    return
            }
            UIView.transition(with: self.view, duration: 0.1, options: .transitionFlipFromBottom, animations: {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let moodPage = storyboard.instantiateViewController(identifier: VCIds.VybzTabVC.rawValue) as! VybzTabVC
              sceneDelegate.window?.rootViewController = moodPage
            }, completion: nil)
        
    }
    
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
        keyboard.delegate = self
        audioEngine.start()
        customizeKeyboardElements()
        setUpChordButtons()
        likebutton.isHidden = true
        likebutton.imageEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        moodColor = setMoodTheme(moodName: chosenMood?.moodName ?? "")
    }
    
    @objc func dismissPopup() {
        popupView.isHidden = true
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
    
    private func setMoodTheme(moodName: String) -> UIColor {
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
        
        guard (chosenMood?.moodChordprogressions.count)! < 4 else  {
    chordButtons[3].setTitle(chosenMood?.moodChordprogressions[3]?.description, for: .normal)
            return
        }
 
        chordButtons[3].setTitle("", for: .normal)
        chordButtons[3].isEnabled = false

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
        scaleButton.backgroundColor = setMoodTheme(moodName: chosenMood?.moodName ?? "")
        chordButton.backgroundColor = setMoodTheme(moodName: chosenMood?.moodName ?? "")
        noteSwitch.onTintColor = setMoodTheme(moodName: chosenMood?.moodName ?? "")
        chordButtons.forEach({$0.isHidden = true})
    }
    
}
