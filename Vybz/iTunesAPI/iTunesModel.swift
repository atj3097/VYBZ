//
//  iTunesModel.swift
//  Vybz
//
//  Created by God on 7/15/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation


import Foundation

// MARK: - Welcome
struct Artist: Codable {
    let resultCount: Int
    let topSongs: [Song]
}

// MARK: - Result
struct Song: Codable {
    let wrapperType: WrapperType
    let kind: Kind
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Double
    let releaseDate: Date
    let collectionExplicitness, trackExplicitness: Explicitness
    let discCount, discNumber, trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country: Country
    let currency: Currency
    let primaryGenreName: String
    let isStreamable: Bool
    let contentAdvisoryRating: ContentAdvisoryRating?
    let collectionArtistID: Int?
    let collectionArtistName: String?
    let collectionArtistViewURL: String?

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable, contentAdvisoryRating
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName
        case collectionArtistViewURL = "collectionArtistViewUrl"
    }
}

enum Explicitness: String, Codable {
    case cleaned = "cleaned"
    case explicit = "explicit"
    case notExplicit = "notExplicit"
}

enum ContentAdvisoryRating: String, Codable {
    case clean = "Clean"
    case explicit = "Explicit"
}

enum Country: String, Codable {
    case usa = "USA"
}

enum Currency: String, Codable {
    case usd = "USD"
}

enum Kind: String, Codable {
    case song = "song"
}

enum WrapperType: String, Codable {
    case track = "track"
}

