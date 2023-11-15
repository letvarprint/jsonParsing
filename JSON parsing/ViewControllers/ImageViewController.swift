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
        
        URLSession.shared.dataTask(with: Link.randomFoxURL.url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                self.foxImage = try jsonDecoder.decode(FoxImage.self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
            
            print(response)
            
              
            self.networkManager.fetchImage(from: self.foxImage.image) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage(data: data)
                            self.activityIndicator.stopAnimating()
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }.resume()
        }
    
}

