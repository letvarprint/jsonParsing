//
//  ViewController.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 12.11.2023.
//

import UIKit



enum UserAction: CaseIterable {
    case fetchHolidays
    case fetchStarWars
    case randomFox
    
    var title: String {
        switch self {
        case .fetchHolidays:
            return "Fetch Holidays"
        case .fetchStarWars:
            return "Fetch Star Wars"
        case .randomFox:
            return "Show image"
        }
    }
}



final class MainViewController: UIViewController {
    
    let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

// MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userAction", for: indexPath) as? UserActionCell else { return UICollectionViewCell() }
        
        cell.userActionLabel.text = userActions[indexPath.item].title
        
        return cell
    }
}


// MARK: UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let userAction = userActions[indexPath.item]
    
    switch userAction {
    case .fetchHolidays:
       fetchHolidays()
        performSegue(withIdentifier: "fetchHolidays", sender: nil)
    case .fetchStarWars:
        fetchStarWars()
    case .randomFox:
        performSegue(withIdentifier: "showImage", sender: nil)
    }
}



}

// MARK: UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 150)
    }
}
// MARK: - Networking
extension MainViewController {
    private func fetchHolidays() {
        URLSession.shared.dataTask(with: Link.holidaysURL.url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let holiday = try jsonDecoder.decode([Holiday].self, from: data)
                print(holiday)
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
    
    private func fetchStarWars() {
        URLSession.shared.dataTask(with: Link.starWarsURL.url) { data, _ , error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let starWars = try jsonDecoder.decode(StarWars.self, from: data)
                print(starWars)
            } catch let error {
                print(error.localizedDescription)
            }
            
            
        }.resume()
    }
}
