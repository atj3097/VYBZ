//
//  VybzTests.swift
//  VybzTests
//
//  Created by God on 12/10/19.
//  Copyright © 2019 God. All rights reserved.
//

import XCTest
@testable import Vybz

class VybzTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSongsData() {
        // Arrange
        let songData = getsongJSONData()

        // Act
        var topSongs = [Song]()
   
        do {
            topSongs = try Artist.getTopSongs(from: songData)

        }
        catch {
            print(error)
        }

        // Assert
        XCTAssertTrue(topSongs.count == 50, "Was expecting 50 song structs, but received \(topSongs.count)")
    }

    private func getsongJSONData() -> Data {
        guard let pathToData = Bundle.main.path(forResource: "itunes", ofType: "json") else {
            fatalError("itunes.json file not found")
        }

        let internalUrl = URL(fileURLWithPath: pathToData)
        do {
            let data = try Data(contentsOf: internalUrl)
            print(data)
            return data
        }
        catch {
            fatalError("An error occurred: \(error)")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
