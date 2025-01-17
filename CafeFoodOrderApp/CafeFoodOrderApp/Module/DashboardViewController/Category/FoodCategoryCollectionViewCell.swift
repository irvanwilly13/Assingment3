//
//  FoodCategoryCollectionViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit

class FoodCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    func setup(item: Category) {
        nameLabel.text = item.name
        imgView.image = UIImage(named: item.icon)
        
        // Download the image from the URL (if it exists) and set it to imgView
        if let url = URL(string: item.icon) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(String(describing: error))")
                    return
                }
                // Set the downloaded image to imgView on the main thread
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data)
                }
            }.resume() // Start the download task
        }
    }
}
