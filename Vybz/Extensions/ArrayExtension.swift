//
//  ArrayExtension.swift
//  Vybz
//
//  Created by God on 1/11/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation
import MusicTheorySwift
extension Array {
    func scaleToString(notes: [Key], octave: Int) -> [String] {
        let newString = notes
        var arrayOfPitches = [Pitch]()
                var arrayOfNextOctave = [Pitch]()
               for i in newString {
                    arrayOfPitches.append(Pitch(key: i, octave: octave ))
                }
               for i in newString {
                    arrayOfNextOctave.append(Pitch(key: i, octave: 5))
                }
                var pitchString = arrayOfPitches.description
               pitchString = pitchString.replacingOccurrences(of: "[", with: "")
                pitchString = pitchString.replacingOccurrences(of: "]", with: "")
                var pitchArray = [String]()
                var pitchArray2 = [String]()
                var noteString = String()
                pitchArray = pitchString.components(separatedBy: ",")
                print(pitchArray)
                for i in pitchArray {
                    if i.contains(" ") {
                        noteString = i
                        noteString.removeFirst()
                        pitchArray2.append(noteString)
                    }
                    else {
                        noteString = i
                        pitchArray2.append(noteString)
                    }
                }
        return pitchArray2
    }
    func accountForAccidentals(notes: [String], octave: Int) -> [String] {
        var newArr = notes
        for (index, i) in notes.enumerated() {
            if i == "G♯\(octave)" {
                newArr.insert("A♭\(octave)", at: index)
            }
            else if i == "D♯\(octave)" {
                newArr.insert("E♭\(octave)", at: index)
            }
            else if i == "A♯\(octave)" {
                newArr.insert("B♭\(octave)", at: index)
            }
           else if i == "G♭\(octave)" {
              newArr.insert("F♯5", at: index)
           }
            else if i == "A𝄫\(octave)" {
              newArr.insert("G\(octave)", at: index)
           }
            else if i == "B♭\(octave)" {
              newArr.insert("C\(octave)", at: index)
           }
            else if i == "C♭\(octave)" {
               newArr.insert("D♯\(octave)", at: index)
           }
            else if i == "D♭\(octave)" {
               newArr.insert("C♯\(octave)", at: index)
           }
            else if i == "E𝄫\(octave)" {
               newArr.insert("D\(octave)", at: index)
           }
            else if i == "F♭\(octave)" {
              newArr.insert("E\(octave)", at: index)
           }
           else if i == "B𝄫\(octave)" {
              newArr.insert("C\(octave)", at: index)
           }
        }
        return newArr
    }
}
