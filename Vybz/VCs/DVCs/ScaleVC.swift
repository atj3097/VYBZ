//
//  ScaleVC.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import MusicTheorySwift
import GLNPianoView
class ScaleVC: UIViewController, GLNPianoViewDelegate {
    private let audioEngine = AudioEngine()
    
    @IBOutlet weak var keyboard: GLNPianoView!
    
    @IBOutlet weak var fascia: UIView!
    
    
    
    
    @IBAction func showNotes(_ sender: UISwitch) {
        keyboard.toggleShowNotes()
    }
    
    
    
    
    
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
         audioEngine.start()
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
        keyboard.highlightKeys(noteNames: score[position], color: UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.35), play: play)
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
                    self?.keyboard.reset(didPlay: play)
                }
            }
        }
    }

}
