//
//  MoodCell.swift
//  Vybz
//
//  Created by God on 12/10/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import SwiftSiriWaveformView
import AVFoundation
class MoodCell: UICollectionViewCell {
    var timer:Timer?
    var player: AVAudioPlayer?
    var change:CGFloat = 0.01
    var isPlaying: Bool = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var moodLabel: UILabel!
    @IBAction func playMusic(_ sender: UIButton) {
        switch isPlaying{
        case false:
            
        self.audioView.isHidden = false
         timer = Timer.scheduledTimer(timeInterval: 0.009999, target: self, selector: #selector(MoodCell.refreshAudioView(_:)), userInfo: nil, repeats: true)
            isPlaying = true
        playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            playSound()
        case true:
            player?.stop()
            isPlaying = false
             self.audioView.isHidden = true
            playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            
        }
    }
    
    @IBOutlet weak var audioView: SwiftSiriWaveformView!
    @IBOutlet weak var moodDescription: UILabel!
    @IBOutlet weak var moodIcon: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        isPlaying = false
        self.audioView.isHidden = true
    self.audioView.density = 1.0
        
       
    }
    func bind(color: String, imageName: String) {
        contentView.backgroundColor = color.hexColor
    }
    
    @objc internal func refreshAudioView(_:Timer) {
        if self.audioView.amplitude <= self.audioView.idleAmplitude || self.audioView.amplitude > 1.0 {
            self.change *= -0.5
        }
        
        // Simply set the amplitude to whatever you need and the view will update itself.
        self.audioView.amplitude += self.change
    }
}
extension MoodCell {
func playSound() {
    if let asset = NSDataAsset(name:"Happy"){
    
          do {
                // Use NSDataAsset's data property to access the audio file stored in Sound.
                 player = try AVAudioPlayer(data:asset.data, fileTypeHint:"caf")
                // Play the above sound file.
                player?.play()
          } catch let error as NSError {
                print(error.localizedDescription)
          }
       }
   
}
}
