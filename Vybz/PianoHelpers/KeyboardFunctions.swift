//
//  KeyboardFunctions.swift
//  Vybz
//
//  Created by God on 2/23/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation
import MusicTheorySwift

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
//               firebaseChord1 = chordOne
//               firebaseChord2 = chordTwo
//               firebaseChord3 = chordThree
//               firebaseChord4 = chordFour
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
        chordString = chordString.accountForAccidentals(notes: chordString, octave: 4)
            autoHighlight(score: [chordString],
                          position: 0, loop: false, tempo: 100.0, play: true, keyboard: keyboard)
        }
    
    //MARK: Plays individual Chords
    func playChordSender(tag: Int, currentChordProgression: [Chord?]?, keyboard: GLNPianoView) {
         let progression = currentChordProgression
        switch tag {
        case 0:
            let chordArray = [progression![0]?.keys[0], progression![0]?.keys[1],progression![0]?.keys[2],progression![0]?.keys[3]]
            playChordAudio(chord: chordArray as! [Key], keyboard: keyboard)
        case 1:
            let chordArrayTwo = [progression![1]?.keys[0], progression![1]?.keys[1],progression![1]?.keys[2],progression![1]?.keys[3]]
            playChordAudio(chord: chordArrayTwo as! [Key], keyboard: keyboard)
        case 2:
             let chordArrayThree = [progression![2]?.keys[0], progression![2]?.keys[1],progression![2]?.keys[2],progression![2]?.keys[3]]
             playChordAudio(chord: chordArrayThree as! [Key], keyboard: keyboard)
        case 3:
            let chordArrayFour = [progression![3]?.keys[0], progression![3]?.keys[1],progression![3]?.keys[2],progression![3]?.keys[3]]
            playChordAudio(chord: chordArrayFour as! [Key], keyboard: keyboard)
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
