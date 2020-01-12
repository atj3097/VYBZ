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
//MARK: Make save possible in Firebase
struct FireMood {
    let moodName: String?
    let uid: String
    let chordProgression: String?
    let scale: String?
 
//
//    init(from mood: Mood) {
//        self.moodName = mood.moodName
//        self.chordProgression = mood.
//    }
    
//
//    init(from user: User) {
//        self.chordProgression = user.displayName
//        self.moodName = user.email
//        self.uid = user.uid
//        self.scale
//
//    }
//
//    init?(from dict: [String: Any], id: String) {
//        guard let userName = dict["userName"] as? String,
//            let email = dict["email"] as? String,
//            //MARK: TODO - extend Date to convert from Timestamp?
//            let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
//
//        self.chordProgression = userName
//        self.moodName = email
//        self.uid = id
//        self.scale = dateCreated
//
//    }
//
//    var fieldsDict: [String: Any] {
//        return [
//            "userName": self.chordProgression ?? "",
//            "email": self.moodName ?? ""
//        ]
//    }
}
