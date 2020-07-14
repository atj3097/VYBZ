//
//  FavoriteProtocol.swift
//  Vybz
//
//  Created by God on 12/12/19.
//  Copyright © 2019 God. All rights reserved.
//


import Foundation
public protocol Favorable {
    var itemId: String {get}
    var imageURL: String {get}
    var mainDescription: String {get}
    var subtitleDescription: String {get}

}
