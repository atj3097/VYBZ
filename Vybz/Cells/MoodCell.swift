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
    @IBOutlet weak var gif: UIImageView!
    @IBOutlet weak var nowPlaying: UILabel!
    var assetName:String?
    var gifName: String?
    var timer:Timer?
    var player: AVAudioPlayer?
    var change:CGFloat = 0.01
    var isPlaying: Bool = false
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var moodLabel: UILabel!
    @IBAction func playMusic(_ sender: UIButton) {
        switch isPlaying{
        case false:
            gif.isHidden = false
        self.audioView.isHidden = false
        nowPlaying.isHidden = false
         timer = Timer.scheduledTimer(timeInterval: 0.009, target: self, selector: #selector(MoodCell.refreshAudioView(_:)), userInfo: nil, repeats: true)
            isPlaying = true
        playButton.setImage(UIImage(systemName: "pause"), for: .normal)
            if moodIcon.image == UIImage(named: "icons8-sci-fi-80")  {
                UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .curveEaseInOut,.autoreverse], animations: {
                    self.moodIcon.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
                    self.moodLabel.transform = CGAffineTransform(translationX: 0.0, y: 20.0)
                })
            }
        if moodIcon.image == UIImage(named: "icons8-love-96")  {
             let pulse1 = CASpringAnimation(keyPath: "transform.scale")
             pulse1.duration = 0.6
             pulse1.fromValue = 1.0
             pulse1.toValue = 1.12
             pulse1.autoreverses = true
             pulse1.repeatCount = 1
             pulse1.initialVelocity = 0.5
             pulse1.damping = 0.8
     
             let animationGroup = CAAnimationGroup()
             animationGroup.duration = 2.7
             animationGroup.repeatCount = 1000
             animationGroup.animations = [pulse1]
            moodIcon.layer.add(animationGroup, forKey: "pulse")
     
                }
            if moodIcon.image == UIImage(named: "icons8-palm-tree-96")  {
                UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .curveEaseInOut,.autoreverse], animations: {
                    self.moodIcon.transform = CGAffineTransform(rotationAngle: 0.2)
                                       
                                   })
            
                       }

        self.gif.image = UIImage.gif(asset: self.gifName ?? "")
            playSound()
        case true:
            gif.isHidden = true
            nowPlaying.isHidden = true
            self.audioView.isHidden = true
            player?.stop()
            isPlaying = false
            animateLogo()
            playButton.setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        }
    }
    
    @IBOutlet weak var audioView: SwiftSiriWaveformView!
    @IBOutlet weak var moodDescription: UILabel!
    @IBOutlet weak var moodIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        isPlaying = false
    self.audioView.density = 1.0
    self.audioView.isHidden = true
        nowPlaying.isHidden = true
        gif.isHidden = true
       
    }
    func bind(color: String, imageName: String) {
        contentView.backgroundColor = color.hexColor
    }
    
     @objc internal func refreshAudioView(_:Timer) {
           if self.audioView.amplitude <= self.audioView.idleAmplitude || self.audioView.amplitude > 1.0 {
               self.change *= -1.0
           }
           
           // Simply set the amplitude to whatever you need and the view will update itself.
           self.audioView.amplitude += self.change
       }
}
extension MoodCell {
func playSound() {
    if let asset = NSDataAsset(name:assetName ?? ""){
    
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

func animateLogo() {
    UIView.animate(withDuration: 1.0, delay: 0.3, options: [ .curveEaseInOut], animations: {
        self.audioView.transform = CGAffineTransform(translationX: 0.0, y: -20.0)
    })
}
}
