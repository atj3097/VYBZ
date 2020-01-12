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
public var scaleNames = ["Major", "Minor","Blues", "Spanish", "Dorian"]

class PianoVC: UIViewController, GLNPianoViewDelegate {
    private let audioEngine = AudioEngine()
    private var chosenKey: Key?
    private var chosenScale: Scale?
    private var chosenScaleType: ScaleType?
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
        chosenScaleType = .major
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func pianoKeyDown(_ keyNumber: Int) {
        audioEngine.sampler.startNote(UInt8(keyboard.octave + keyNumber), withVelocity: 64, onChannel: 0)
        
    }
    
    func pianoKeyUp(_ keyNumber: Int) {
        audioEngine.sampler.stopNote(UInt8(keyboard.octave + keyNumber), onChannel: 0)
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
        switch pickerView.tag {
        case 0:
            switch row {
            case 0:
                print("")
                chosenScale = Scale(type: chosenScaleType ?? ScaleType.major, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            case 1:
                chosenScale = Scale(type: chosenScaleType ?? ScaleType.minor, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            case 2:
                chosenScale = Scale(type: chosenScaleType ?? ScaleType.blues, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            case 3:
                chosenScale = Scale(type: chosenScaleType ?? ScaleType.spanishGypsy, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            case 4:
                chosenScale = Scale(type: chosenScaleType ?? ScaleType.dorian, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            default:
                print("Not being chosen")
            }
        case 1:
            switch row {
            case 0:
                chosenScaleType = .major
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            case 1:
                chosenScaleType = .minor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chromaticScale.keys[row])
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            case 2:
                chosenScaleType = .minor
                chosenScale = Scale(type: chosenScaleType ?? .major, key: chromaticScale.keys[row])
                
                lightUpKeys(scale: chosenScale!, keyboard: self.keyboard)
            default:
                print("Not being chosen")
            }
            
        default:
            print("")
        }
        
    }
    
}
