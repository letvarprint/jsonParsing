//
//  Holiday.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 12.11.2023.
//

import Foundation

struct Holiday: Decodable {
    let countries: [String]?
    let countryCode: String?
    let date: String?
    let fixed: Bool?
    let global: Bool?
    let launchYear: Int?
    let localName: String?
    let name: String?
    let type: String?
}
