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
    
    init(holidayData: [String: Any]) {
        countryCode = holidayData["countryCode"] as? String ?? ""
        date = holidayData["date"] as? String ?? ""
        name = holidayData["name"] as? String ?? ""
        type = holidayData["type"] as? String ?? ""
        countries = holidayData["countries"] as? [String] ?? []
        fixed = holidayData["fixed"] as? Bool ?? true
        global = holidayData["global"] as? Bool ?? true
        launchYear = holidayData["launchYear"] as? Int ?? 0
        localName = holidayData["localName"] as? String ?? ""
    }
    
    
    static func getHolidays(from value: Any) -> [Holiday] {
        guard let holidaysData = value as? [[String: Any]] else { return [] }
        return holidaysData.compactMap { Holiday(holidayData: $0) }
    }
}
