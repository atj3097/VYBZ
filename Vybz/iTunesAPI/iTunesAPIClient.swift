//
//  iTunesAPIClient.swift
//  Vybz
//
//  Created by God on 7/15/20.
//  Copyright © 2020 God. All rights reserved.
//

import Foundation

class iTunesAPIManager {
    private init() {}

    static let shared = iTunesAPIManager()

    func getSong(artistName: String, completionHandler: @escaping (Result<[Song], AppError>) -> Void) {
        let urlStr = "https://itunes.apple.com/search?term=\(artistName)&entity=musicTrack"
        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }


        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
            case .failure(let error) :
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let artistInfo = try JSONDecoder().decode(Artist.self, from: data)
                    completionHandler(.success(artistInfo.results))
                } catch {
                    print(error)
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }

}
