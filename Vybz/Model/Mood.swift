//
//  Mood.swift
//  Vybz
//
//  Created by God on 12/14/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import MusicTheorySwift

//MARK: Refactor the creation of mood to enums and not strings
//MARK: Create a function that saves your mood to Firebase
var accidentals = "♯,♭"
var allChordProgressions = [ChordProgression.i_ii_vi_iv,ChordProgression.i_iii_vi_iv,ChordProgression.i_iv_ii_v,ChordProgression.i_iv_vi_v,ChordProgression.i_v_ii_iv,ChordProgression.i_v_iv_v,ChordProgression.i_v_vi_iv,ChordProgression.i_vi_ii_v,ChordProgression.ii_iv_i_v,ChordProgression.iv_i_v_iv]

public enum Moods: String {
    case happy
    case chill
    case dark
    case spacy
    case bright
    case love
    case soul
    case island
    case exotic
  
}

struct MoodColors {
    static let happy = #colorLiteral(red: 0.9547634721, green: 0.2656957507, blue: 0.2108009458, alpha: 1)
    static let chill = #colorLiteral(red: 0.577150166, green: 0.1428382397, blue: 0.6492669582, alpha: 1)
    static let dark = #colorLiteral(red: 0.2450211346, green: 0.319488436, blue: 0.7105911374, alpha: 1)
    static let spacy = #colorLiteral(red: 0.006004863419, green: 0.6619215608, blue: 0.9581366181, alpha: 1)
    static let bright = #colorLiteral(red: 0, green: 0.5901898742, blue: 0.5330483317, alpha: 1)
    static let love = #colorLiteral(red: 0.5080210567, green: 0.7082751393, blue: 0.2693652809, alpha: 1)
    static let soul = #colorLiteral(red: 1, green: 0.9216297865, blue: 0.2307302356, alpha: 1)
    static let island = #colorLiteral(red: 0.998616159, green: 0.5976478457, blue: 0, alpha: 1)
    static let exotic = #colorLiteral(red: 0.4743168354, green: 0.3322603106, blue: 0.2815309763, alpha: 1)
}

struct Mood {
    var moodName: String
    var moodKey: Key
    var moodScale: Scale
    var moodChordprogressions: [Chord?]
    
    //MARK: Enum creator
    func enumCreator(moodSelected: String) -> Moods {
        var moodSelec: Moods!
        switch moodSelected {
        case "happy":
            moodSelec = Moods.happy
        case "mellow":
            moodSelec = Moods.chill
        case "dark":
            moodSelec = Moods.dark
        case "spacy":
            moodSelec = Moods.spacy
        case "bright":
            moodSelec = Moods.bright
        case "sorrow":
            moodSelec = Moods.spacy
        case "jazzy":
            moodSelec = Moods.soul
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
                harmonicField: .tetrad,
                inversion: 0
            )
            print(newProgression)
            
           newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
            
        case "chill":
            moodScale = Scale(type: .dorian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "dark":
            moodScale = Scale(type: .phrygian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "spacy":
            moodScale = Scale(type: .lydian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "bright":
            moodScale = Scale(type: .mixolydian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "love":
            moodScale = Scale(type: .aeolian, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "soul":
            moodScale = Scale(type: .blues, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "island":
            moodScale = Scale(type: .pentatonicMajor, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        case "exotic":
            moodScale = Scale(type: .spanishGypsy, key: key)
            //Progressions Available
            let newProgression = allChordProgressions.randomElement()!.chords(
                for: moodScale,
                harmonicField: .tetrad,
                inversion: 0
            )
            newMood = Mood(moodName: name, moodKey: key, moodScale: moodScale, moodChordprogressions: newProgression)
        default:
            print(" ")
        }
        return newMood
    }
    
}

