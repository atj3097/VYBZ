//
//  iTunesModel.swift
//  Vybz
//
//  Created by God on 7/15/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Artist: Codable {
    let resultCount: Int
    let results: [Song]
    
    static func getTopSongs(from JSONData: Data) -> [Song] {
        do {
            let topSongs = try JSONDecoder().decode([Song].self, from: JSONData)
            return topSongs
        }
        catch {
            return []
        }
    }
}

// MARK: - Result
struct Song: Codable {
    let artistName, collectionName, trackName, collectionCensoredName: String?
    let artistViewURL, collectionViewURL, trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String?
}
