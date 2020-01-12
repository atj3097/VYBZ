//
//  VCExtension.swift
//  Vybz
//
//  Created by God on 1/12/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import GLNPianoView 

extension UIViewController {
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
    func lightUpKeys(scale: Scale,keyboard: GLNPianoView) {
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
