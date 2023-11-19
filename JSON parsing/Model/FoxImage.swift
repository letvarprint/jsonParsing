//
//  randomFox.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 12.11.2023.
//

import Foundation

struct FoxImage: Decodable {
    var image: String?
   private var link: String?
    
    
    init(foxData: [String: Any]) {
        image = foxData["image"] as? String ?? nil
        link = foxData["link"] as? String ?? nil
    }
    
    
    static func getFox(from value: Any) -> FoxImage? {
        guard let foxData = value as? [String: Any] else {return nil }
        return FoxImage(foxData: foxData)
    }
}

