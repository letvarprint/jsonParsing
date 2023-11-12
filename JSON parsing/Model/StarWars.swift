//
//  StarWars.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 12.11.2023.
//

import Foundation

struct StarWars: Decodable {
    let climate: String?
    let created: String?
    let diameter: String?
    let edited: String?
    let films: [String]?
    let gravity: String?
    let name: String?
    let orbital_period: String?
    let population: String?
    let residents: [String]?
    let rotation_period: String?
    let surface_water: String?
    let terrain: String?
    let url: String?
}
