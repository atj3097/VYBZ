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
    
    @IBOutlet weak var keyboard: GLNPianoView!
    @IBOutlet weak var scaleButton: UIButton!
    @IBOutlet weak var chordButton: UIButton!
    @IBOutlet weak var noteSwitch: UISwitch!
    @IBOutlet weak var fascia: UIView!
    var chordDemo = true
    var chosenMood: Mood?
    var moodString: String?
    var chosenKey: Key?
    var firebaseChord1: [String]?
    var firebaseChord2: [String]?
    var firebaseChord3: [String]?
    var firebaseChord4: [String]?
    var firebaseScale: [String]?
    
    @IBOutlet weak var likebutton: UIButton!
    @IBAction func showNotes(_ sender: UISwitch) {
        keyboard.toggleShowNotes()
    }
    @IBOutlet var chords: [UIButton]!
    
    @IBAction func playAll(_ sender: UIButton) {
        playAllChords()
        
    }
    @IBAction func playChordProgression(_ sender: UIButton) {
        chords.forEach({$0.isHidden = false})
    }
    
    @IBAction func playChord(_ sender: UIButton) {
        playChordSender(tag: sender.tag)
    }
    @IBAction func showScale(_ sender: UIButton) {
        highlightScale()
    }
    
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
         let layer = CAGradientLayer()
               layer.frame = fascia.bounds
               layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
               layer.startPoint = CGPoint(x: 0.0, y: 0.80)
               layer.endPoint = CGPoint(x: 0.0, y: 1.0)
               fascia.layer.insertSublayer(layer, at: 0)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        likebutton.addTarget(self, action: #selector(saveMood), for: .touchUpInside)
        scaleButton.roundButton(button: scaleButton)
        chordButton.roundButton(button: chordButton)
        scaleButton.backgroundColor = moodColor
        chordButton.backgroundColor = moodColor
        keyboard.delegate = self
        noteSwitch.onTintColor = moodColor
        audioEngine.start()
        setUpChordButtons()
        let add = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveMood))
        add.image = UIImage(systemName: "heart")
        self.navigationItem.rightBarButtonItem = add
        chords.forEach({$0.isHidden = true})
    }
    
    func pianoKeyDown(_ keyNumber: Int) {
        audioEngine.sampler.startNote(UInt8(keyboard.octave + keyNumber), withVelocity: 64, onChannel: 0)
    }

    func pianoKeyUp(_ keyNumber: Int) {
        audioEngine.sampler.stopNote(UInt8(keyboard.octave + keyNumber), onChannel: 0)
    }
      
}

extension ScaleVC {
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
        chords[0].setTitle(chosenMood?.moodChordprogressions[0]?.description, for: .normal)
               chords[1].setTitle(chosenMood?.moodChordprogressions[1]?.description, for: .normal)
               chords[2].setTitle(chosenMood?.moodChordprogressions[2]?.description, for: .normal)
               chords[3].setTitle(chosenMood?.moodChordprogressions[3]?.description, for: .normal)
    }
    
    //MARK: Chord Progression
    func playAllChords() {
        let chordProgression = chosenMood?.moodChordprogressions
        let chordArrayOne = [chordProgression![0]?.keys[0], chordProgression![0]?.keys[1],chordProgression![0]?.keys[2],chordProgression![0]?.keys[3]]
        let chordArrayTwo = [chordProgression![1]?.keys[0], chordProgression![1]?.keys[1],chordProgression![1]?.keys[2],chordProgression![1]?.keys[3]]
        let chordArrayThree = [chordProgression![2]?.keys[0], chordProgression![2]?.keys[1],chordProgression![2]?.keys[2],chordProgression![2]?.keys[3]]
         let chordArrayFour = [chordProgression![3]?.keys[0], chordProgression![3]?.keys[1],chordProgression![3]?.keys[2],chordProgression![3]?.keys[3]]
        
        //Chord 1
        var chordOne = [String]()
        chordOne = chordOne.scaleToString(notes: chordArrayOne as! [Key], octave: 4)
        chordOne = chordOne.accountForAccidentals(notes: chordOne, octave: 4)
        //Chord 2
       var chordTwo = [String]()
        chordTwo = chordTwo.scaleToString(notes: chordArrayTwo as! [Key], octave: 4)
       chordTwo = chordTwo.accountForAccidentals(notes: chordOne, octave: 4)
        
        //Chord 3
        var chordThree = [String]()
         chordThree = chordThree.scaleToString(notes: chordArrayThree as! [Key], octave: 4)
        chordThree = chordThree.accountForAccidentals(notes: chordThree, octave: 4)

        //Chord 4
      var chordFour = [String]()
         chordFour = chordFour.scaleToString(notes: chordArrayFour as! [Key], octave: 4)
        chordFour = chordThree.accountForAccidentals(notes: chordFour, octave: 4)
        firebaseChord1 = chordOne
        firebaseChord2 = chordTwo
        firebaseChord3 = chordThree
        firebaseChord4 = chordFour
        if chordDemo {
            autoHighlight(score: [chordOne, chordTwo,chordThree,chordFour],
                          position: 0, loop: false, tempo: 100.0, play: true, keyboard: self.keyboard)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
            ], position: 0, loop: true, tempo: 130.0, play: true, keyboard: self.keyboard)
        }
        
    }
    
    //MARK: Chord Audio
    func playChordAudio(chord: [Key]) {
        var chordString = [String]()
         chordString = chordString.scaleToString(notes: chord, octave: 4)
        chordString = chordString.accountForAccidentals(notes: chordString, octave: 4)
        
        if chordDemo {
            autoHighlight(score: [chordString],
                          position: 0, loop: false, tempo: 100.0, play: true, keyboard: self.keyboard)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
            ], position: 0, loop: true, tempo: 130.0, play: true, keyboard: self.keyboard)
        }

    }
    //MARK: Play Individual Chords
    func playChordSender(tag: Int) {
         let progression = chosenMood?.moodChordprogressions
        switch tag {
        case 0:
            let chordArray = [progression![0]?.keys[0], progression![0]?.keys[1],progression![0]?.keys[2],progression![0]?.keys[3]]
            playChordAudio(chord: chordArray as! [Key])
        case 1:
            let chordArrayTwo = [progression![1]?.keys[0], progression![1]?.keys[1],progression![1]?.keys[2],progression![1]?.keys[3]]
            playChordAudio(chord: chordArrayTwo as! [Key])
        case 2:
             let chordArrayThree = [progression![2]?.keys[0], progression![2]?.keys[1],progression![2]?.keys[2],progression![2]?.keys[3]]
                       playChordAudio(chord: chordArrayThree as! [Key])
        case 3:
            let chordArrayFour = [progression![3]?.keys[0], progression![3]?.keys[1],progression![3]?.keys[2],progression![3]?.keys[3]]
            playChordAudio(chord: chordArrayFour as! [Key])
        default:
            print("No chord")
        }
    }
  
     //MARK: Scale highlighting
    func highlightScale() {
        var octave4 = [String]()
        octave4 = octave4.scaleToString(notes: (chosenMood?.moodScale.keys)!, octave: 4)
        octave4 = octave4.accountForAccidentals(notes: octave4, octave: 4)

         var octave5 = [String]()
        octave5 = octave5.scaleToString(notes: (chosenMood?.moodScale.keys)!, octave: 5)
        octave5 = octave5.accountForAccidentals(notes: octave5, octave: 5)
        let collectiveArray = octave4 + octave5
        firebaseScale = collectiveArray
        print("Firebase: \(firebaseScale!)")
         let chordDemo = true
         if chordDemo {
             autoHighlight(score: [collectiveArray
             ], position: 0, loop: true, tempo: 20.0, play: false, keyboard: self.keyboard)
             
         } else {
             autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                   [Note.name(of: 62)],
                                   [Note.name(of: 63)],
                                   [Note.name(of: 65)],
                                   [Note.name(of: 63)],
                                   [Note.name(of: 62)]
             ], position: 0, loop: true, tempo: 130.0, play: true, keyboard: self.keyboard)
         }
    }
}



