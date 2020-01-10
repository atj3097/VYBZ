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
        convertScaleToString()
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
         var progressionPitches = [Pitch]()
        var progressionPitches2 = [Pitch]()
        var progressionPitches3 = [Pitch]()
        var progressionPitches4 = [Pitch]()
        
        
        for i in chordArrayOne {
            progressionPitches.append(Pitch(key: i!, octave: 4))
        }
        for i in chordArrayTwo {
            progressionPitches2.append(Pitch(key: i!, octave: 4))
        }
        for i in chordArrayThree {
            progressionPitches3.append(Pitch(key: i!, octave: 4))
        }
        for i in chordArrayFour {
            progressionPitches4.append(Pitch(key: i!, octave: 4))
        }
        

          var chordString = progressionPitches.description
        var chordString2 = progressionPitches2.description
        var chordString3 = progressionPitches3.description
        var chordString4 = progressionPitches4.description
        
        
          chordString = chordString.replacingOccurrences(of: "[", with: "")
          chordString = chordString.replacingOccurrences(of: "]", with: "")
            chordString2 = chordString2.replacingOccurrences(of: "[", with: "")
            chordString2 = chordString2.replacingOccurrences(of: "]", with: "")
        chordString3 = chordString3.replacingOccurrences(of: "[", with: "")
        chordString3 = chordString3.replacingOccurrences(of: "]", with: "")
        chordString4 = chordString4.replacingOccurrences(of: "[", with: "")
        chordString4 = chordString4.replacingOccurrences(of: "]", with: "")
        
        //Chord 1
        var chordPitchArray = [String]()
        var chordPitchArray2 = [String]()
        chordPitchArray = chordString.components(separatedBy: ",")
        var chordStringTest = String()
        var chordStringTest2 = String()
        for i in chordPitchArray {
            if i.contains(" ") {
                chordStringTest = i
                chordStringTest.removeFirst()
                chordPitchArray2.append(chordStringTest)
            }
            else {
                chordStringTest = i
                chordPitchArray2.append(chordStringTest)
            }
        }
        //Chord 2
        var chordPitchArray3 = [String]()
        var chordPitchArray4 = [String]()
        chordPitchArray3 = chordString2.components(separatedBy: ",")
        var chordStringTest3 = String()
        var chordStringTest4 = String()
        for i in chordPitchArray3 {
            if i.contains(" ") {
                chordStringTest3 = i
                chordStringTest3.removeFirst()
                chordPitchArray4.append(chordStringTest3)
            }
            else {
                chordStringTest3 = i
                chordPitchArray4.append(chordStringTest3)
            }
        }
        
        //Chord 3
        var chordPitchArray5 = [String]()
        var chordPitchArray6 = [String]()
        chordPitchArray5 = chordString3.components(separatedBy: ",")
        var chordStringTest5 = String()
        var chordStringTest6 = String()
        for i in chordPitchArray5 {
            if i.contains(" ") {
                chordStringTest5 = i
                chordStringTest5.removeFirst()
                chordPitchArray6.append(chordStringTest5)
            }
            else {
                chordStringTest3 = i
                chordPitchArray6.append(chordStringTest5)
            }
        }
        
        //Chord 4
        var chordPitchArray7 = [String]()
        var chordPitchArray8 = [String]()
        chordPitchArray7 = chordString4.components(separatedBy: ",")
        var chordStringTest7 = String()
        var chordStringTest8 = String()
        for i in chordPitchArray7 {
            if i.contains(" ") {
                chordStringTest7 = i
                chordStringTest7.removeFirst()
                chordPitchArray8.append(chordStringTest7)
            }
            else {
                chordStringTest7 = i
                chordPitchArray8.append(chordStringTest7)
            }
        }
        
        
        print(chordPitchArray2)
        print(chordPitchArray4)
        print(chordPitchArray6)
        print(chordPitchArray8)
        
        if chordDemo {
            autoHighlight(score: [chordPitchArray2, chordPitchArray4,chordPitchArray6,chordPitchArray8],
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
    func playChordSender(tag: Int) {
        switch tag {
        case 0:
            let cMajorProgression = chosenMood?.moodChordprogressions
            let chordArrayOne = [cMajorProgression![0]?.keys[0], cMajorProgression![0]?.keys[1],cMajorProgression![0]?.keys[2]]
             var progressionPitches = [Pitch]()
            for i in chordArrayOne {
                progressionPitches.append(Pitch(key: i!, octave: 4))
            }
              var chordString = progressionPitches.description
              chordString = chordString.replacingOccurrences(of: "[", with: "")
              chordString = chordString.replacingOccurrences(of: "]", with: "")
            var chordPitchArray = [String]()
            var chordPitchArray2 = [String]()
            chordPitchArray = chordString.components(separatedBy: ",")
            var chordStringTest = String()
            var chordStringTest2 = String()
            for i in chordPitchArray {
                if i.contains(" ") {
                    chordStringTest = i
                    chordStringTest.removeFirst()
                    chordPitchArray2.append(chordStringTest)
                }
                else {
                    chordStringTest = i
                    chordPitchArray2.append(chordStringTest)
                }
            }
            if chordDemo {
                autoHighlight(score: [chordPitchArray2],
                              position: 0, loop: false, tempo: 130.0, play: true)
                
            } else {
                autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                      [Note.name(of: 62)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 65)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 62)]
                    ], position: 0, loop: true, tempo: 130.0, play: true)
            }
        case 1:
            let cMajorProgression = chosenMood?.moodChordprogressions
            let chordArrayOne = [cMajorProgression![1]?.keys[0], cMajorProgression![1]?.keys[1],cMajorProgression![1]?.keys[2]]
             var progressionPitches = [Pitch]()
            for i in chordArrayOne {
                progressionPitches.append(Pitch(key: i!, octave: 4))
            }
              var chordString = progressionPitches.description
              chordString = chordString.replacingOccurrences(of: "[", with: "")
              chordString = chordString.replacingOccurrences(of: "]", with: "")
            var chordPitchArray = [String]()
            var chordPitchArray2 = [String]()
            chordPitchArray = chordString.components(separatedBy: ",")
            var chordStringTest = String()
            var chordStringTest2 = String()
            for i in chordPitchArray {
                if i.contains(" ") {
                    chordStringTest = i
                    chordStringTest.removeFirst()
                    chordPitchArray2.append(chordStringTest)
                }
                else {
                    chordStringTest = i
                    chordPitchArray2.append(chordStringTest)
                }
            }
            if chordDemo {
                autoHighlight(score: [chordPitchArray2],
                              position: 0, loop: false, tempo: 130.0, play: true)
                
            } else {
                autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                      [Note.name(of: 62)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 65)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 62)]
                    ], position: 0, loop: true, tempo: 130.0, play: true)
            }
        case 2:
            let cMajorProgression = chosenMood?.moodChordprogressions
            let chordArrayOne = [cMajorProgression![2]?.keys[0], cMajorProgression![2]?.keys[1],cMajorProgression![2]?.keys[2]]
             var progressionPitches = [Pitch]()
            for i in chordArrayOne {
                progressionPitches.append(Pitch(key: i!, octave: 4))
            }
              var chordString = progressionPitches.description
              chordString = chordString.replacingOccurrences(of: "[", with: "")
              chordString = chordString.replacingOccurrences(of: "]", with: "")
            var chordPitchArray = [String]()
            var chordPitchArray2 = [String]()
            chordPitchArray = chordString.components(separatedBy: ",")
            var chordStringTest = String()
            var chordStringTest2 = String()
            for i in chordPitchArray {
                if i.contains(" ") {
                    chordStringTest = i
                    chordStringTest.removeFirst()
                    chordPitchArray2.append(chordStringTest)
                }
                else {
                    chordStringTest = i
                    chordPitchArray2.append(chordStringTest)
                }
            }
            if chordDemo {
                autoHighlight(score: [chordPitchArray2],
                              position: 0, loop: false, tempo: 130.0, play: true)
                
            } else {
                autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                      [Note.name(of: 62)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 65)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 62)]
                    ], position: 0, loop: true, tempo: 130.0, play: true)
            }
        case 3:
            let cMajorProgression = chosenMood?.moodChordprogressions
            let chordArrayOne = [cMajorProgression![3]?.keys[0], cMajorProgression![3]?.keys[1],cMajorProgression![3]?.keys[2]]
             var progressionPitches = [Pitch]()
            for i in chordArrayOne {
                progressionPitches.append(Pitch(key: i!, octave: 4))
            }
              var chordString = progressionPitches.description
              chordString = chordString.replacingOccurrences(of: "[", with: "")
              chordString = chordString.replacingOccurrences(of: "]", with: "")
            var chordPitchArray = [String]()
            var chordPitchArray2 = [String]()
            chordPitchArray = chordString.components(separatedBy: ",")
            var chordStringTest = String()
            var chordStringTest2 = String()
            for i in chordPitchArray {
                if i.contains(" ") {
                    chordStringTest = i
                    chordStringTest.removeFirst()
                    chordPitchArray2.append(chordStringTest)
                }
                else {
                    chordStringTest = i
                    chordPitchArray2.append(chordStringTest)
                }
            }
            if chordDemo {
                autoHighlight(score: [chordPitchArray2],
                              position: 0, loop: false, tempo: 130.0, play: true)
                
            } else {
                autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                      [Note.name(of: 62)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 65)],
                                      [Note.name(of: 63)],
                                      [Note.name(of: 62)]
                    ], position: 0, loop: true, tempo: 130.0, play: true)
            }
        default:
            print("")
        }
        
        
        
    }
    func convertChordToString() {
        let cMajorProgression = chosenMood?.moodChordprogressions
        let chordArrayOne = [cMajorProgression![0]?.keys[0], cMajorProgression![0]?.keys[1],cMajorProgression![0]?.keys[2]]
        print(chordArrayOne)
        let chordArrayTwo = [cMajorProgression![2]?.keys[0],cMajorProgression![2]?.keys[1],cMajorProgression![2]?.keys[2]]
        print(chordArrayTwo)
        
        
            var progressionPitches = [Pitch]()
            var progressionPitches2 = [Pitch]()
            for i in chordArrayOne {
                progressionPitches.append(Pitch(key: i!, octave: 4))
            }
            for i in chordArrayTwo {
                progressionPitches2.append(Pitch(key: i!, octave: 4))
            }
            var chordString = progressionPitches.description
            var chordString2 = progressionPitches2.description
            chordString = chordString.replacingOccurrences(of: "[", with: "")
            chordString = chordString.replacingOccurrences(of: "]", with: "")
            chordString2 = chordString2.replacingOccurrences(of: "[", with: "")
            chordString2 = chordString2.replacingOccurrences(of: "]", with: "")
            var chordPitchArray = [String]()
            var chordPitchArray2 = [String]()
            var chordPitchArray3 = [String]()
            var chordPitchArray4 = [String]()
            chordPitchArray = chordString.components(separatedBy: ",")
            chordPitchArray3 = chordString2.components(separatedBy: ",")
            print(chordPitchArray)
            var chordStringTest = String()
            var chordStringTest2 = String()
            for i in chordPitchArray {
                if i.contains(" ") {
                    chordStringTest = i
                    chordStringTest.removeFirst()
                    chordPitchArray2.append(chordStringTest)
                }
                else {
                    chordStringTest = i
                    chordPitchArray2.append(chordStringTest)
                }
            }
        
            for i in chordPitchArray3 {
                if i.contains(" ") {
                    chordStringTest2 = i
                    chordStringTest2.removeFirst()
                    chordPitchArray4.append(chordStringTest2)
                }
                else {
                    chordStringTest2 = i
                    chordPitchArray4.append(chordStringTest2)
                }
            }
        
                if chordDemo {
                    autoHighlight(score: [chordPitchArray2],
                                  position: 0, loop: true, tempo: 130.0, play: true)
                    
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
    func convertScaleToString() {
        var keysInScale = chosenMood?.moodScale.keys
         var arrayOfPitches = [Pitch]()
         var arrayOfNextOctave = [Pitch]()
        for i in keysInScale! {
             arrayOfPitches.append(Pitch(key: i, octave: 4))
         }
        for i in keysInScale! {
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
         for (index, i) in pitchArray2.enumerated() {
             if i == "G♯4" {
                 pitchArray2.insert("A♭4", at: index)
             }
             else if i == "D♯4" {
                 pitchArray2.insert("E♭4", at: index)
             }
             else if i == "A♯4" {
                 pitchArray2.insert("B♭4", at: index)
             }
             else if i == "G♭4" {
                pitchArray2.insert("F♯4", at: index)
            }
             else if i == "A𝄫4" {
                pitchArray2.insert("G4", at: index)
            }
             else if i == "B♭4" {
                pitchArray2.insert("C4", at: index)
            }
             else if i == "C♭4" {
                pitchArray2.insert("D♯4", at: index)
            }
             else if i == "D♭4" {
                pitchArray2.insert("C♯4", at: index)
            }
             else if i == "E𝄫4" {
                pitchArray2.insert("D4", at: index)
            }
             else if i == "F♭4" {
                pitchArray2.insert("E4", at: index)
            }
         }
         print(pitchArray2)
         
         var pitchArray3 = [String]()
         var pitchArray4 = [String]()
         var pitchString2 = arrayOfNextOctave.description
         pitchString2 = pitchString2.replacingOccurrences(of: "[", with: "")
         pitchString2 = pitchString2.replacingOccurrences(of: "]", with: "")
         var noteString2 = String()
         pitchArray3 = pitchString2.components(separatedBy: ",")
         for i in pitchArray3 {
             if i.contains(" ") {
                 noteString2 = i
                 noteString2.removeFirst()
                 pitchArray4.append(noteString2)
             }
             else {
                 noteString2 = i
                 pitchArray4.append(noteString2)
             }
         }
         for (index, i) in pitchArray4.enumerated() {
             if i == "G♯5" {
                 pitchArray4.insert("A♭5", at: index)
             }
             else if i == "D♯5" {
                 pitchArray4.insert("E♭5", at: index)
             }
             else if i == "A♯5" {
                 pitchArray4.insert("B♭5", at: index)
             }
            else if i == "G♭5" {
                pitchArray2.insert("F♯5", at: index)
            }
             else if i == "A𝄫5" {
                pitchArray2.insert("G5", at: index)
            }
             else if i == "B♭5" {
                pitchArray2.insert("C5", at: index)
            }
             else if i == "C♭5" {
                pitchArray2.insert("D♯5", at: index)
            }
             else if i == "D♭5" {
                pitchArray2.insert("C♯5", at: index)
            }
             else if i == "E𝄫5" {
                pitchArray2.insert("D5", at: index)
            }
             else if i == "F♭5" {
                pitchArray2.insert("E5", at: index)
            }
            else if i == "B𝄫5" {
                pitchArray2.insert("C5", at: index)
            }
         }
         print(pitchArray4)
         var collectiveArray = pitchArray2
         collectiveArray += pitchArray4
         
         // Auto highlighting
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

extension Array {
    func removeSpaces(notes: [String]) -> [String] {
        var newString = notes
        
        return newString
    }
    func accountForAccidentals(notes: [String]) -> [String] {
        var newArr = notes
        for (index, i) in notes.enumerated() {
            if i == "G♯5" {
                newArr.insert("A♭5", at: index)
            }
            else if i == "D♯5" {
                newArr.insert("E♭5", at: index)
            }
            else if i == "A♯5" {
                newArr.insert("B♭5", at: index)
            }
           else if i == "G♭5" {
              newArr.insert("F♯5", at: index)
           }
            else if i == "A𝄫5" {
              newArr.insert("G5", at: index)
           }
            else if i == "B♭5" {
              newArr.insert("C5", at: index)
           }
            else if i == "C♭5" {
               newArr.insert("D♯5", at: index)
           }
            else if i == "D♭5" {
               newArr.insert("C♯5", at: index)
           }
            else if i == "E𝄫5" {
               newArr.insert("D5", at: index)
           }
            else if i == "F♭5" {
              newArr.insert("E5", at: index)
           }
           else if i == "B𝄫5" {
              newArr.insert("C5", at: index)
           }
        }
        return newArr
    }
}
