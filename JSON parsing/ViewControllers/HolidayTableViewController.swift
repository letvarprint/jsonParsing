//
//  HolidayTableViewController.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 16.11.2023.
//

import UIKit

class HolidayTableViewController: UITableViewController {
    
    private let networkManager = NetworkManager.shared
    
    private var holidays: [Holiday] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHoliday()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        holidays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holidayCell", for: indexPath)
        guard let cell = cell as? HolidayCell else { return UITableViewCell() }
        
        let holiday = holidays[indexPath.row]
        cell.configure(with: holiday)

        return cell
    }
}

// MARK: - Networking
extension HolidayTableViewController {
    func fetchHoliday() {
        networkManager.fetchHolidays(url: Link.holidaysURL.url) { data in
            self.holidays = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
