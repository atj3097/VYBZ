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
    let moodName: String?
    let moodKey: String
    let uid: String
    let chordProgression: String?
    let scale: String?
    
    
    init(name: String, key: String, userID: String, chordProgression: String, scale: String) {
        self.moodName = name
        self.moodKey = key
        self.uid = userID
        self.chordProgression = chordProgression
        self.scale = scale
        
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let moodName = dict["moodName"] as? String,
            let moodKey = dict["moodKey"] as? String,
            let userID = dict["userID"] as? String,
            let chordProgression = dict["chordProgression"] as? String, let scale = dict["scale"] as? String else { return nil }
        
        self.moodName = moodName
        self.moodKey = moodKey
        self.uid = userID
        self.chordProgression = chordProgression
        self.scale = scale
    }
    var fieldsDict: [String: Any] {
        return [
            "moodName": self.moodName,
            "moodKey": self.moodKey,
            "uid": self.uid,
            "chordProgression": self.chordProgression,
            "scale": self.scale
        ]
    }
    
    
}
