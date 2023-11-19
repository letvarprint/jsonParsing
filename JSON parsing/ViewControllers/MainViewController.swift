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
        performSegue(withIdentifier: "fetchHolidays", sender: nil)
    case .fetchStarWars: break
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

