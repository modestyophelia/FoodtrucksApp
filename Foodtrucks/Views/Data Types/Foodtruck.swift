//
//  Foodtruck.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-10-28.
//

import Foundation

struct Foodtruck: Codable, Identifiable {
    var id: String
    var title: String
    var description: String
    var image: String
    var coordinates: Coordinates
    var openingHours: String
    var reviews: [Review]
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}

struct Review : Codable, Identifiable {
    var id: String
    var rating: Int
    var reviewTitle: String
    var reviewText: String
}

