//
//  KeyboardFunctions.swift
//  Vybz
//
//  Created by God on 2/23/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation
import MusicTheorySwift
public var keyboardSequence = ["C4", "C"]
class KeyboardFunctions {
    //MARK: Highlight Function
    public func autoHighlight(score: [[String]], position: Int, loop: Bool, tempo: Double, play: Bool,keyboard: GLNPianoView) {
        keyboard.highlightKeys(score[position], color: moodColor.withAlphaComponent(0.60), play: play)
        let delay = 120.0/tempo
        let nextPosition = position + 1
        if nextPosition < score.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.autoHighlight(score: score, position: nextPosition, loop: loop, tempo: tempo, play: play, keyboard: keyboard)
            }
        } else {
            if loop {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                    self?.autoHighlight(score: score, position: 0, loop: loop, tempo: tempo, play: play, keyboard: keyboard)
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                    keyboard.reset()
                }
            }
        }
    }
    
    
    //MARK: Scale highlighting
    func lightUpKeys(scale: Scale,keyboard: GLNPianoView, loop: Bool) {
        var octave4 = [String]()
        octave4 = octave4.scaleToString(notes: (scale.keys), octave: 4)
        octave4 = octave4.accountForAccidentals(notes: octave4, octave: 4)
        
        var octave5 = [String]()
        octave5 = octave5.scaleToString(notes: (scale.keys), octave: 5)
        octave5 = octave5.accountForAccidentals(notes: octave5, octave: 5)
        let collectiveArray = octave4 + octave5
        
        let chordDemo = true
        if chordDemo {
            autoHighlight(score: [collectiveArray
            ], position: 0, loop: loop, tempo: 0.000000000000000000000000000000000000000001, play: false, keyboard: keyboard)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
            ], position: 0, loop: true, tempo: 130.0, play: true, keyboard: keyboard)
        }
    }
    
    //MARK: Play Chord Progression
    func playAllChords(currentChordProgression: [Chord?]?, keyboard: GLNPianoView) {
        let chordDemo = true
        let chordProgression = currentChordProgression
        let chordArrayOne = currentChordProgression![0]
        let chordArrayTwo = currentChordProgression![1]
        let chordArrayThree = currentChordProgression![2]
        let chordArrayFour = currentChordProgression![3]
        
        //Chord 1
        var chordOne = [String]()
        chordOne = chordOne.scaleToString(notes: chordArrayOne!.keys, octave: 4)
        chordOne = chordOne.accountForAccidentals(notes: chordOne, octave: 4)
        chordOne = chordOne.extendToNextOctave(chordString: chordOne, chord: chordArrayOne!.keys)
        //Chord 2
        var chordTwo = [String]()
        chordTwo = chordTwo.scaleToString(notes: chordArrayTwo!.keys, octave: 4)
        chordTwo = chordTwo.accountForAccidentals(notes: chordTwo, octave: 4)
        chordTwo = chordTwo.extendToNextOctave(chordString: chordTwo, chord: chordArrayTwo!.keys)
        
        //Chord 3
        var chordThree = [String]()
        chordThree = chordThree.scaleToString(notes: chordArrayThree!.keys, octave: 4)
        chordThree = chordThree.accountForAccidentals(notes: chordThree, octave: 4)
        chordThree = chordThree.extendToNextOctave(chordString: chordThree, chord: chordArrayThree!.keys)
        
        //Chord 4
        var chordFour = [String]()
        chordFour = chordFour.scaleToString(notes: chordArrayFour!.keys, octave: 4)
        chordFour = chordThree.accountForAccidentals(notes: chordFour, octave: 4)
        chordFour = chordFour.extendToNextOctave(chordString: chordFour, chord: chordArrayFour!.keys)
        print(chordOne)
        print(chordTwo)
        
        if chordDemo {
            autoHighlight(score: [chordOne, chordTwo,chordThree,chordFour],
                          position: 0, loop: false, tempo: 100.0, play: true, keyboard: keyboard)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
            ], position: 0, loop: true, tempo: 130.0, play: true, keyboard: keyboard)
        }
    }
    
    //MARK: Plays audio of Chord
    //Calls highlight function
    func playChordAudio(chord: [Key], keyboard: GLNPianoView) {
        var chordString = [String]()
        chordString = chordString.scaleToString(notes: chord, octave: 4)
        print("Keys To String \(chordString)")
        chordString = chordString.accountForAccidentals(notes: chordString, octave: 4)
        print("Account For Accidentals \(chordString)")
        chordString = chordString.extendToNextOctave(chordString: chordString, chord: chord)
        print("Extend to Next Octave \(chordString)")
        
//        let rootIndex = Int(allNotes.firstIndex(of: chordString.first ?? "")!)
//        let lastIndex = allNotes.count - 1
//        let remainingNotes = allNotes[rootIndex...lastIndex]
//        print(chordString)
//        print(remainingNotes)
//
//        for (index,note) in chordString.enumerated() {
//            print("Current note: \(note)")
//            if !remainingNotes.contains(note) {
//                var newNote = note.dropLast()
//                chordString.remove(at: index)
//                chordString.insert("\(newNote)5", at: index)
//            }
//
//            //Opts out Suspended Chords
//            if chord.count > 3 {
//                //Does not allow any editing to 2nd Index if it is a close degree
//                if index > 1 {
//
//                    if remainingNotes.count > 2 {
//
//                        //Checking for clashing notes
//                        if note == "\(remainingNotes[rootIndex + 1])" || note == "\(remainingNotes[rootIndex + 2])" || note == "\(remainingNotes[rootIndex + 3])" || note == "\(remainingNotes[rootIndex + 4])"  {
//                            print("Remaining Notes: \(remainingNotes)")
//                            chordString.remove(at: index)
//                            var replacementNote = note.dropLast()
//                            chordString.insert("\(replacementNote)5", at: index)
//                        }
//                    }
//                }
//            }
//            //Checks to see whether or not youre in the 5th octave
//            if note != chordString.first {
//                if chordString[index - 1].last == Character("5") {
//                    chordString.remove(at: index)
//                    var replacementNote = note.dropLast()
//                    chordString.insert("\(replacementNote)5", at: index)
//                }
//            }
//        }
        
        autoHighlight(score: [chordString],
                      position: 0, loop: false, tempo: 100.0, play: true, keyboard: keyboard)
    }
    
    //MARK: Plays individual Chords
    func playChordSender(tag: Int, currentChordProgression: [Chord?]?, keyboard: GLNPianoView) {
        let progression = currentChordProgression
        switch tag {
        case 0:
            let chordArray = progression![0]
            playChordAudio(chord: chordArray!.keys, keyboard: keyboard)
        case 1:
            let chordArrayTwo = progression![1]
            playChordAudio(chord: chordArrayTwo!.keys, keyboard: keyboard)
        case 2:
            let chordArrayThree = progression![2]
            playChordAudio(chord: chordArrayThree!.keys, keyboard: keyboard)
        case 3:
            let chordArrayFour = progression![3]
            playChordAudio(chord: chordArrayFour!.keys, keyboard: keyboard)
        default:
            print("No chord")
        }
    }
    
    func highlightScale(currentScale: Scale, keyboard: GLNPianoView) {
        var octave4 = [String]()
        octave4 = octave4.scaleToString(notes: currentScale.keys, octave: 4)
        octave4 = octave4.accountForAccidentals(notes: octave4, octave: 4)
        var octave5 = [String]()
        octave5 = octave5.scaleToString(notes: currentScale.keys, octave: 5)
        octave5 = octave5.accountForAccidentals(notes: octave5, octave: 5)
        let collectiveArray = octave4 + octave5
        let chordDemo = true
        if chordDemo {
            autoHighlight(score: [collectiveArray
            ], position: 0, loop: true, tempo: 20.0, play: false, keyboard: keyboard)
            
        } else {
            autoHighlight(score: [[Note.name(of: 60), Note.name(of: 63), Note.name(of: 67)],
                                  [Note.name(of: 62)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 65)],
                                  [Note.name(of: 63)],
                                  [Note.name(of: 62)]
            ], position: 0, loop: true, tempo: 130.0, play: true, keyboard: keyboard)
        }
    }
    
}
