//
//  PianoVC.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import GLNPianoView
//MARK: TO DO - Complete scales to choose from
//MARK: TO DO - Find A Better way to do put data into the picker view

public var scaleNames = ["Major", "Pentatonic(Major)", "Minor","Harmonic Minor","Melodic Minor", "Pentatonic Minor", "Blues", "Spanish", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Locrian", "Ionian", "Aeolian"]
public var chordNames = ["Major","Major 7","Major 9","Major 11","Major 13", "Minor", "Minor 7", "Minor 9", "Minor 11", "Minor 13", "Dim", "Augmented", "Sus2", "Sus4", "Major 6", "Minor 6" ,"7sus4", "7b5"]

class PianoVC: UIViewController, GLNPianoViewDelegate {
    
    //MARK: Variables
    private let audioEngine = AudioEngine()
    private var isHighlighting = false
    private var chosenKey: Key?
    private var chosenScale: Scale?
    private var chosenScaleType: ScaleType?
    private var chosenChord: Chord?
    let keyboardFunctions = KeyboardFunctions()
    private var chosenChordType: ChordType?
    @IBOutlet weak var keyboard: GLNPianoView!
    @IBOutlet weak var fascia: UIView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var keyPickerView: UIPickerView!
    @IBOutlet weak var chordPickerView: UIPickerView!
    
    //MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        let layer = CAGradientLayer()
        layer.frame = fascia.bounds
        layer.colors = [UIColor.black.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
        layer.startPoint = CGPoint(x: 0.0, y: 0.80)
        layer.endPoint = CGPoint(x: 0.0, y: 1.0)
        fascia.layer.insertSublayer(layer, at: 0)
    }
    override func viewDidLayoutSubviews() {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
        chordPickerView.subviews[1].isHidden = true
        chordPickerView.subviews[2].isHidden = true
        keyPickerView.subviews[1].isHidden = true
        keyPickerView.subviews[2].isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboard.delegate = self
        audioEngine.start()
        pickerView.delegate = self
        chordPickerView.delegate = self
        pickerView.dataSource = self
        keyPickerView.delegate = self
        keyPickerView.dataSource = self
        chordPickerView.dataSource = self
        
    }
    
    func pianoKeyDown(_ keyNumber: Int) {
        audioEngine.sampler.startNote(UInt8(keyboard.octave + keyNumber), withVelocity: 64, onChannel: 0)
    }
    func pianoKeyUp(_ keyNumber: Int) {
        audioEngine.sampler.stopNote(UInt8(keyboard.octave + keyNumber), onChannel: 0)
    }
    
    func setInitialScale() {
        chosenScaleType = .major
        chosenKey = Key(type: .c, accidental: .natural)
        chosenScale = Scale(type: .major, key: chosenKey!)
    }
}

//MARK: Picker Extension
extension PianoVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return chromaticScale.keys.count
        case 1:
            return scaleNames.count
        case 2:
            return chordNames.count
        default:
            print("")
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        switch pickerView.tag {
        case 0:
            
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "Avenir-Next-Bold", size: 40)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = "\(chromaticScale.keys[row])"
            pickerLabel?.textColor = UIColor.white
            pickerLabel?.font = UIFont(name: "Avenir Next", size: 20)
            pickerLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            return pickerLabel!
        case 1:
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "Avenir Next", size: 20)
                pickerLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = scaleNames[row]
            pickerLabel?.textColor = UIColor.white
            return pickerLabel!
            
        case 2:
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "Avenir Next", size: 20)
                pickerLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = "\(chordNames[row])"
            pickerLabel?.textColor = UIColor.white
            return pickerLabel!
            
        default:
            print("")
        }
        return pickerLabel!
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        //MARK: Key Picker
        case 0:
            switch row {
            case 0:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 1:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 2:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 3:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 4:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 5:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 6:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 7:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 8:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 9:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 10:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 12:
                chosenKey = chromaticScale.keys[row]
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey!)
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            default:
                print("Not being chosen")
            }
        case 1:
            //MARK: Scale Picker
            switch row {
            case 0:
                chosenScaleType = .major
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 1:
                chosenScaleType = .pentatonicMajor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 2:
                chosenScaleType = .minor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 3:
                chosenScaleType = .harmonicMinor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 4:
                chosenScaleType = .melodicMinor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 5:
                chosenScaleType = .pentatonicMinor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 6:
                chosenScaleType = .blues
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
                
            case 7:
                chosenScaleType = .spanishGypsy
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 8:
                chosenScaleType = .dorian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 9:
                chosenScaleType = .phrygian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 10:
                chosenScaleType = .lydian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 11:
                chosenScaleType = .mixolydian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 12:
                chosenScaleType = .locrian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 13:
                chosenScaleType = .ionian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            case 14:
                chosenScaleType = .aeolian
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chosenKey ?? Key(type: .c))
                lightUpKeys(scale: chosenScale!, keyboard: keyboard, loop: false)
            default:
                print("Not being chosen")
            }
            
        case 2:
            //MARK: Chord Picker
            switch row {
            case 0:
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: chosenChordType! , key: chosenKey ?? Key(type: .c), inversion: 0)
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
            case 1:
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .major, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 2:
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .major, suspended: .none, extensions: [(ChordExtensionType(interval: .M9)!)], custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
            case 3:
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .major, suspended: .none, extensions: [(ChordExtensionType(interval: .M9)!), (ChordExtensionType(interval: .P11)!)], custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 4:
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .major, suspended: .none, extensions: [(ChordExtensionType(interval: .M9)!), (ChordExtensionType(interval: .P11)!), (ChordExtensionType(interval: .M13)!)], custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            //MARK: Minor Chords
            case 5:
                chosenChordType = ChordType(third: .minor)
                chosenChord = Chord(type: chosenChordType! , key: chosenKey ?? Key(type: .c), inversion: 0)
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 6:
                chosenChordType = ChordType(third: .minor)
                chosenChord = Chord(type: .init(third: .minor, fifth: .perfect, sixth: .none, seventh: .dominant, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
            case 7:
                chosenChordType = ChordType(third: .minor)
                chosenChord = Chord(type: .init(third: .minor, fifth: .perfect, sixth: .none, seventh: .dominant, suspended: .none, extensions: [(ChordExtensionType(interval: .M9)!)], custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 8:
                chosenChordType = ChordType(third: .minor)
                chosenChord = Chord(type: .init(third: .minor, fifth: .perfect, sixth: .none, seventh: .dominant, suspended: .none, extensions: [(ChordExtensionType(interval: .M9)!), (ChordExtensionType(interval: .P11)!)], custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
            case 9:
                chosenChordType = ChordType(third: .minor)
                chosenChord = Chord(type: .init(third: .minor, fifth: .perfect, sixth: .none, seventh: .dominant, suspended: .none, extensions: [(ChordExtensionType(interval: .M9)!), (ChordExtensionType(interval: .P11)!), (ChordExtensionType(interval: .m13)!)], custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 10:
                chosenChordType = ChordType(third: .minor)
                chosenChord = Chord(type: .init(third: .minor, fifth: .diminished, sixth: .none, seventh: .none, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
            case 11:
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: .init(third: .major, fifth: .agumented, sixth: .none, seventh: .none, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 12:
                
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .none, suspended: .sus2, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                var susChord = chosenChord!.keys
                susChord.remove(at: 1)
                keyboardFunctions.playChordAudio(chord: susChord, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 13:
                
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .none, suspended: .sus4, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                var susChord = chosenChord!.keys
                susChord.remove(at: 1)
                keyboardFunctions.playChordAudio(chord: susChord, keyboard: keyboard)
                print(chosenChord?.description)
                
            case 14:
                var sixthChord = ChordSixthType(interval: .M6)
                chosenChordType = ChordType(third: .major)
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: sixthChord, seventh: .none, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
            case 15:
                var sixthChord = ChordSixthType(interval: .M6)
            chosenChord = Chord(type: .init(third: .minor, fifth: .perfect, sixth: sixthChord, seventh: .none, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
            keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)
            case 16:
                chosenChord = Chord(type: .init(third: .major, fifth: .perfect, sixth: .none, seventh: .dominant, suspended: .sus4, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                var susChord = chosenChord!.keys
                susChord.remove(at: 1)
                keyboardFunctions.playChordAudio(chord: susChord, keyboard: keyboard)
            case 17:
                chosenChord = Chord(type: .init(third: .major, fifth: .diminished, sixth: .none, seventh: .dominant, suspended: .none, extensions: .none, custom: .none), key: chosenKey ?? Key(type: .c))
                keyboardFunctions.playChordAudio(chord: chosenChord!.keys, keyboard: keyboard)


            default:
                print("Not being chosen")
            }
            
        default:
            print("")
        }
        
    }
    
}
