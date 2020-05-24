//
//  ArrayExtension.swift
//  Vybz
//
//  Created by God on 1/11/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation
import MusicTheorySwift
public var allNotes = [
    "C4", "C♯4","D♭4","D4","D♯4","E♭4","E4","F4","F♯4","G♭4","G4","G♯4","A♭4","A4", "A♯4","B♭4","B4"
]
public var flatNotes = ["C4","D♭4","D4","E♭4","E4","F4","G♭4","G4","A♭4","B♭4","B4"]
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
    
    func chordToString(notes: [Key], octave: Int) -> [String] {
        let notesToConvert = notes
        
        var arrayOfPitches = [Pitch]()
        
        var arrayOfNextOctave = [Pitch]()
        
        for i in notesToConvert {
            arrayOfPitches.append(Pitch(key: i, octave: octave))
        }
        
        for i in notesToConvert {
            arrayOfNextOctave.append(Pitch(key: i, octave: 5))
        }
        
        var pitchString = arrayOfPitches.description
        pitchString = pitchString.replacingOccurrences(of: "[", with: "")
        pitchString = pitchString.replacingOccurrences(of: "]", with: "")
        var pitchArray = [String]()
        var pitchArray2 = [String]()
        var noteString = String()
        pitchArray = pitchString.components(separatedBy: ",")
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
