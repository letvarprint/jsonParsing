//
//  ImageViewController.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 12.11.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    
    var foxImage: FoxImage!
    
    let networkManager = NetworkManager.shared
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    
    private func fetchImage() {
        networkManager.fetchFox(url: Link.randomFoxURL.url) { url in
            self.networkManager.fetchImage(from: url) { result in
                switch result {
                case.success(let data):
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                        self.activityIndicator.stopAnimating()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } 
    }
}


