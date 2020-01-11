//
//  ScaleVC.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.
//
/*
 TO DO: Account for double accidentals
 Account for adding another octave for chords
 */
import UIKit
import MusicTheorySwift
import GLNPianoView
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
    
    lazy var likeButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(systemName: "heard"), for: .normal)
        return button
    }()
    
    
    
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
        keyboard.delegate = self
        noteSwitch.onTintColor = moodColor
         audioEngine.start()
        setUpChordButtons()
        chords.forEach({$0.isHidden = true})
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func pianoKeyDown(_ keyNumber: Int) {
        audioEngine.sampler.startNote(UInt8(keyboard.octave + keyNumber), withVelocity: 64, onChannel: 0)
       
    }

    func pianoKeyUp(_ keyNumber: Int) {
        audioEngine.sampler.stopNote(UInt8(keyboard.octave + keyNumber), onChannel: 0)
    }
    func autoHighlight(score: [[String]], position: Int, loop: Bool, tempo: Double, play: Bool) {
        keyboard.highlightKeys(score[position], color: moodColor.withAlphaComponent(0.60), play: play)
        let delay = 120.0/tempo
        let nextPosition = position + 1
        if nextPosition < score.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.autoHighlight(score: score, position: nextPosition, loop: loop, tempo: tempo, play: play)
            }
        } else {
            if loop {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                    self?.autoHighlight(score: score, position: 0, loop: loop, tempo: tempo, play: play)
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                    self?.keyboard.reset()
                }
            }
        }
    }
}
extension ScaleVC {
    func setUpChordButtons() {
        chords[0].setTitle(chosenMood?.moodChordprogressions[0]?.description, for: .normal)
               chords[1].setTitle(chosenMood?.moodChordprogressions[1]?.description, for: .normal)
               chords[2].setTitle(chosenMood?.moodChordprogressions[2]?.description, for: .normal)
               chords[3].setTitle(chosenMood?.moodChordprogressions[3]?.description, for: .normal)
    }
    func playAllChords() {
        let cMajorProgression = chosenMood?.moodChordprogressions
        let chordArrayOne = [cMajorProgression![0]?.keys[0], cMajorProgression![0]?.keys[1],cMajorProgression![0]?.keys[2]]
        let chordArrayTwo = [cMajorProgression![1]?.keys[0], cMajorProgression![1]?.keys[1],cMajorProgression![1]?.keys[2]]
        let chordArrayThree = [cMajorProgression![2]?.keys[0], cMajorProgression![2]?.keys[1],cMajorProgression![2]?.keys[2]]
         let chordArrayFour = [cMajorProgression![3]?.keys[0], cMajorProgression![3]?.keys[1],cMajorProgression![3]?.keys[2]]
        
        //Chord 1
        var chordOne = [String]()
        chordOne = chordOne.scaleToString(notes: [(cMajorProgression![0]?.keys[0])!, (cMajorProgression![0]?.keys[1])!,(cMajorProgression![0]?.keys[2])!], octave: 4)
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
        
        if chordDemo {
            autoHighlight(score: [chordOne, chordTwo,chordThree,chordFour],
                          position: 0, loop: false, tempo: 100.0, play: true)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
                ], position: 0, loop: true, tempo: 130.0, play: true)
        }
        
    }
    
    
    func playChordAudio(chord: [Key]) {
        var chordString = [String]()
         chordString = chordString.scaleToString(notes: chord, octave: 4)
        chordString = chordString.accountForAccidentals(notes: chordString, octave: 4)
        
        if chordDemo {
            autoHighlight(score: [chordString],
                          position: 0, loop: false, tempo: 100.0, play: true)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
                ], position: 0, loop: true, tempo: 130.0, play: true)
        }

    }
    //MARK: Play Individual Chords
    func playChordSender(tag: Int) {
         let progression = chosenMood?.moodChordprogressions
        switch tag {
        case 0:
            let chordArray = [progression![0]?.keys[0], progression![0]?.keys[1],progression![0]?.keys[2]]
            playChordAudio(chord: chordArray as! [Key])
        case 1:
            let chordArrayTwo = [progression![1]?.keys[0], progression![1]?.keys[1],progression![1]?.keys[2]]
            playChordAudio(chord: chordArrayTwo as! [Key])
        case 2:
             let chordArrayThree = [progression![2]?.keys[0], progression![2]?.keys[1],progression![2]?.keys[2]]
                       playChordAudio(chord: chordArrayThree as! [Key])
        case 3:
            let chordArrayFour = [progression![3]?.keys[0], progression![3]?.keys[1],progression![3]?.keys[2]]
            playChordAudio(chord: chordArrayFour as! [Key])
        default:
            print("No chord")
        }
    }
  
    func highlightScale() {
        var octave4 = [String]()
        octave4 = octave4.scaleToString(notes: (chosenMood?.moodScale.keys)!, octave: 4)
        octave4 = octave4.accountForAccidentals(notes: octave4, octave: 4)

         var octave5 = [String]()
        octave5 = octave5.scaleToString(notes: (chosenMood?.moodScale.keys)!, octave: 5)
        octave5 = octave5.accountForAccidentals(notes: octave5, octave: 5)
        let collectiveArray = octave4 + octave5
  
         //MARK: Scale highlighting
         let chordDemo = true
         if chordDemo {
             autoHighlight(score: [collectiveArray
                 ], position: 0, loop: true, tempo: 20.0, play: false)
             
         } else {
             autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                   [Note.name(of: 62)],
                                   [Note.name(of: 63)],
                                   [Note.name(of: 65)],
                                   [Note.name(of: 63)],
                                   [Note.name(of: 62)]
                 ], position: 0, loop: true, tempo: 130.0, play: true)
         }
    }
}

//MARK: Array Extension

extension Array {
    func scaleToString(notes: [Key], octave: Int) -> [String] {
        let newString = notes
        var arrayOfPitches = [Pitch]()
                var arrayOfNextOctave = [Pitch]()
               for i in newString {
                    arrayOfPitches.append(Pitch(key: i, octave: octave ))
                }
               for i in newString {
                    arrayOfNextOctave.append(Pitch(key: i, octave: 5))
                }
                var pitchString = arrayOfPitches.description
               pitchString = pitchString.replacingOccurrences(of: "[", with: "")
                pitchString = pitchString.replacingOccurrences(of: "]", with: "")
                var pitchArray = [String]()
                var pitchArray2 = [String]()
                var noteString = String()
                pitchArray = pitchString.components(separatedBy: ",")
                print(pitchArray)
                for i in pitchArray {
                    if i.contains(" ") {
                        noteString = i
                        noteString.removeFirst()
                        pitchArray2.append(noteString)
                    }
                    else {
                        noteString = i
                        pitchArray2.append(noteString)
                    }
                }
        return pitchArray2
    }
    func accountForAccidentals(notes: [String], octave: Int) -> [String] {
        var newArr = notes
        for (index, i) in notes.enumerated() {
            if i == "G♯\(octave)" {
                newArr.insert("A♭\(octave)", at: index)
            }
            else if i == "D♯\(octave)" {
                newArr.insert("E♭\(octave)", at: index)
            }
            else if i == "A♯\(octave)" {
                newArr.insert("B♭\(octave)", at: index)
            }
           else if i == "G♭\(octave)" {
              newArr.insert("F♯5", at: index)
           }
            else if i == "A𝄫\(octave)" {
              newArr.insert("G\(octave)", at: index)
           }
            else if i == "B♭\(octave)" {
              newArr.insert("C\(octave)", at: index)
           }
            else if i == "C♭\(octave)" {
               newArr.insert("D♯\(octave)", at: index)
           }
            else if i == "D♭\(octave)" {
               newArr.insert("C♯\(octave)", at: index)
           }
            else if i == "E𝄫\(octave)" {
               newArr.insert("D\(octave)", at: index)
           }
            else if i == "F♭\(octave)" {
              newArr.insert("E\(octave)", at: index)
           }
           else if i == "B𝄫\(octave)" {
              newArr.insert("C\(octave)", at: index)
           }
        }
        return newArr
    }
}
