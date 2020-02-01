//
//  favCell.swift
//  Vybz
//
//  Created by God on 1/18/20.
//  Copyright © 2020 God. All rights reserved.
//

import UIKit

class favCell: UICollectionViewCell, GLNPianoViewDelegate {
    
    private let audioEngine = AudioEngine()
     @IBOutlet weak var fascia: UIView!
    @IBOutlet weak var keyboard: GLNPianoView!
    @IBOutlet weak var scaleButton: UIButton!
    @IBOutlet weak var chordButton: UIButton!
    @IBOutlet weak var showNotes: UISwitch!
    @IBOutlet var chords: [UIButton]!
    @IBOutlet weak var playChords: UIButton!
    
    @IBAction func showNotes(_ sender: UISwitch) {
        keyboard.toggleShowNotes()
    }
    
    @IBAction func playChordProgression(_ sender: UIButton) {
        chords.forEach({$0.isHidden = false})
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        audioEngine.start()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func pianoKeyDown(_ keyNumber: Int) {
        audioEngine.sampler.startNote(UInt8(keyboard.octave + keyNumber), withVelocity: 64, onChannel: 0)
       
    }

    func pianoKeyUp(_ keyNumber: Int) {
        audioEngine.sampler.stopNote(UInt8(keyboard.octave + keyNumber), onChannel: 0)
    }
    
    
    
}
