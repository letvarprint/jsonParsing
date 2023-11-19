//
//  HolidayCell.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 16.11.2023.
//

import UIKit

class HolidayCell: UITableViewCell {

    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with holiday: Holiday) {
        countryCodeLabel.text = holiday.countryCode
        dateLabel.text = holiday.date
        nameLabel.text = holiday.name
        typeLabel.text = holiday.type
        
    }
    

}
