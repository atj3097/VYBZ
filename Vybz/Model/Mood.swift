//
//  Mood.swift
//  Vybz
//
//  Created by God on 12/14/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation
import MusicTheorySwift
var accidentals = "♯,♭"
var allChordProgressions = [ChordProgression.i_ii_vi_iv,ChordProgression.i_iii_vi_iv,ChordProgression.i_iv_ii_v,ChordProgression.i_iv_vi_v,ChordProgression.i_v_ii_iv,ChordProgression.i_v_iv_v,ChordProgression.i_v_vi_iv,ChordProgression.i_vi_ii_v,ChordProgression.ii_iv_i_v,ChordProgression.iv_i_v_iv]

enum Moods {
    case happy
    case mellow
    case dark
    case spacy
    case bright
    case sorrow
    case jazzy
    case island
    case exotic
}

struct Mood {
    var moodName: String
    var moodKey: Key
    var moodScale: Scale
    var moodChordprogressions: [Chord?]
    
    //MARK: Enum creator
    //Mood Enum
    func enumCreator(moodSelected: String) -> Moods {
        var moodSelec: Moods!
        switch moodSelected {
        case "happy":
            moodSelec = Moods.happy
        case "mellow":
            moodSelec = Moods.mellow
        case "dark":
            moodSelec = Moods.dark
        case "spacy":
            moodSelec = Moods.spacy
        case "bright":
            moodSelec = Moods.bright
        case "sorrow":
            moodSelec = Moods.spacy
        case "jazzy":
            moodSelec = Moods.jazzy
        case "island":
            moodSelec = Moods.island
        case "exotic":
            moodSelec = Moods.exotic
        default:
            print(" ")
        }
        return moodSelec
    }
    //MARK: Assigns text to key
    func createKey(cellKey: String) -> Key {
        var newKey: Key!
        switch cellKey {
        case "a":
            newKey = Key(type: .a, accidental: .natural)
        case "b♭":
            newKey = Key(type: .b, accidental: .flat)
        case "b":
            newKey = Key(type: .b, accidental: .natural)
        case "c":
            newKey = Key(type: .c, accidental: .natural)
        case "c♯":
            newKey = Key(type: .c, accidental: .sharp)
        case "d":
            newKey = Key(type: .d, accidental: .natural)
        case "e♭":
            newKey = Key(type: .e, accidental: .flat)
        case "e":
            newKey = Key(type: .e, accidental: .natural)
        case "f":
            newKey = Key(type: .f, accidental: .natural)
        case "f♯":
            newKey = Key(type: .f, accidental: .sharp)
        case "g":
            newKey = Key(type: .g, accidental: .natural)
        case "g♯":
            newKey = Key(type: .g, accidental: .sharp)
        default:
            print(" ")
        }
        return newKey
    }
    //MARK: Creates Mood
   static func moodCreator(name: String, key: Key) -> Mood {
        var newMood: Mood!
        var moodScale: Scale!
        let progression: ChordProgression!
        var moodChordProgressions = [Chord?]()
        
        switch name {
        case "happy":
            //Scale Created
            moodScale = Scale(type: .major, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            print(newProgression)
            
           newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
            
        case "mellow":
            moodScale = Scale(type: .dorian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "dark":
            moodScale = Scale(type: .phrygian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "spacy":
            moodScale = Scale(type: .lydian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "bright":
            moodScale = Scale(type: .mixolydian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "sorrow":
            moodScale = Scale(type: .aeolian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "jazzy":
            moodScale = Scale(type: .blues, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "island":
            moodScale = Scale(type: .pentatonicMajor, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "exotic":
            moodScale = Scale(type: .spanishGypsy, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .triad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        default:
            print(" ")
        }
        
        return newMood
        
    }
    
    
    //MARK: Convert Notes To Numbers
    
//    func convertNoteToNumber(scale: [Key]) -> [Int] {
//        var noteNumber = [Int]()
//        var allKeys = chromaticScale.keys
//        for notes in scale {
//            if allKeys[0] == notes {
//                noteNumber.append(0)
//            }
//            else if allKeys[1] == notes {
//                noteNumber.append(1)
//            }
//            else if allKeys[1] == notes {
//                noteNumber.append(2)
//            }
//            else if allKeys[2] == notes {
//                noteNumber.append(2)
//            }
//            else if allKeys[3] == notes {
//                noteNumber.append(3)
//            }
//            else if allKeys[4] == notes {
//                noteNumber.append(4)
//            }
//            else if allKeys[5] == notes {
//                noteNumber.append(5)
//            }
//            else if allKeys[6] == notes {
//                noteNumber.append(6)
//            }
//            else if allKeys[7] == notes {
//                noteNumber.append(7)
//            }
//            else if allKeys[8] == notes {
//                noteNumber.append(8)
//            }
//            else if allKeys[9] == notes {
//                noteNumber.append(9)
//            }
//            else if allKeys[10] == notes {
//                noteNumber.append(10)
//            }
//            else if allKeys[11] == notes {
//                noteNumber.append(11)
//            }
//
//        }
//        return noteNumber
//    }
}

