//
//  PianoVC.swift
//  Vybz
//
//  Created by God on 12/13/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit

import UIKit
import MusicTheorySwift
import GLNPianoView
public var scaleNames = ["Major", "Minor"]
class PianoVC: UIViewController, GLNPianoViewDelegate {
    private let audioEngine = AudioEngine()
    private var chosenKey: Key?
    private var chosenScale: Scale?
    @IBOutlet weak var keyboard: GLNPianoView!
    
    @IBOutlet weak var fascia: UIView!
    

    
    
    @IBAction func showNotes(_ sender: UISwitch) {
        keyboard.toggleShowNotes()
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var keyPickerView: UIPickerView!
    
    
    
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
        pickerView.delegate = self
        pickerView.dataSource = self
        keyPickerView.delegate = self
        keyPickerView.dataSource = self
        
    
        
        
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
        keyboard.highlightKeys(score[position], color: UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.35), play: play)
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
        default:
            print("")
        }
        return 0
    }
    
    
    //    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return apiOptions[row]
    //    }
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
            return pickerLabel!
        case 1:
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont(name: "Avenir-Next-Bold", size: 40)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = scaleNames[row]
            pickerLabel?.textColor = UIColor.white
            return pickerLabel!
        default:
            print("")
        }
        return pickerLabel!
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            print("")

        case 1:
            print("")
            
        default:
            print("Not being chosen")
        }
        
    }
    
}
