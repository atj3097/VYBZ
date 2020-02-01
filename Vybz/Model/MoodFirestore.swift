//
//  MoodFirestore.swift
//  Vybz
//
//  Created by God on 1/11/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct FaveMood {
    let moodName: String
    let moodKey: String
    let uid: String
    let chordProgression1: [String]
    let chordProgression2: [String]
    let chordProgression3: [String]
    let chordProgression4: [String]
    let scale: [String]
    
    
    init(name: String, key: String, userID: String, chordProgression1: [String], chordProgression2:[String], chordprogression3: [String], chordProgression4: [String], scale: [String]) {
        self.moodName = name
        self.moodKey = key
        self.uid = userID
        self.chordProgression1 = chordProgression1
        self.chordProgression2 = chordProgression2
        self.chordProgression3 = chordprogression3
        self.chordProgression4 = chordProgression4
        self.scale = scale
        
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let moodName = dict["moodName"] as? String,
            let moodKey = dict["moodKey"] as? String,
            let userID = dict["userID"] as? String,
            let chordProgression1 = dict["chordProgression1"] as? [String], let chordProgression2 = dict["chordProgression2"] as? [String], let chordProgression3 = dict["chordProgression3"] as? [String], let chordProgression4 = dict["chordProgression4"] as? [String],  let scale = dict["scale"] as? [String] else { return nil }
        
        self.moodName = moodName
        self.moodKey = moodKey
        self.uid = userID
        self.chordProgression1 = chordProgression1
        self.chordProgression2 = chordProgression2
        self.chordProgression3 = chordProgression3
        self.chordProgression4 = chordProgression4
        self.scale = scale
    }
    var fieldsDict: [String: Any] {
        return [
            "moodName": self.moodName,
            "moodKey": self.moodKey,
            "uid": self.uid,
            "chord1": self.chordProgression1,
            "chord2": self.chordProgression2,
            "chord3": self.chordProgression3,
            "chord4": self.chordProgression4,
            "scale": self.scale
        ]
    }
    
    
}
