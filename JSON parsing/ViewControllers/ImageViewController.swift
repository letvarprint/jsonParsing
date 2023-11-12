//
//  ImageViewController.swift
//  JSON parsing
//
//  Created by Alexandru Brixencov on 12.11.2023.
//

import UIKit

final class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        fetchImage()
    }
    
    private func fetchImage() {
        guard let url = URL(string: FoxImage.link!) else {
                print("Invalid URL")
            return
            }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
                self.activityIndicator.stopAnimating()
            }
            
            
            print(response)
        }.resume()
    }
  
}
