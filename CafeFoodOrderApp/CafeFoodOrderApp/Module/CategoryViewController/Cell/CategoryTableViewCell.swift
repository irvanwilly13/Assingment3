//
//  CategoryTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    
    var isFavorite: Bool = false {
            didSet {
                updateFavoriteButton()
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            // Konfigurasi awal
            configureView()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        // Konfigurasi tampilan awal
        func configureView() {
            // Membulatkan sudut containerView
            containerView.layer.cornerRadius = 10
            containerView.layer.masksToBounds = false
            containerView.layer.shadowColor = UIColor.black.cgColor
            containerView.layer.shadowOpacity = 0.1
            containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
            containerView.layer.shadowRadius = 4
            
            // Membuat gambar menjadi bulat (jika diinginkan)
            imgView.layer.cornerRadius = imgView.frame.height / 2
            imgView.clipsToBounds = true
        }
        
        // Memperbarui tampilan tombol favorite berdasarkan status `isFavorite`
        func updateFavoriteButton() {
            let favoriteImage = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            isFavoriteButton.setImage(favoriteImage, for: .normal)
        }
        
        // Fungsi untuk mengonfigurasi cell dengan data dari model
        func configure(with food: FeaturedRestaurant) {
            nameLabel.text = food.name
            descLabel.text = food.description
            priceLabel.text = "Rp. \(String(describing: food.price))"
            ratingLabel.text = "\(food.rating) "
            reviewsLabel.text = "\(food.reviews) reviews"
            imgView.image = UIImage(named: food.image) // Pastikan gambar sesuai
            
            // Set status favorite
            isFavorite = food.isFavorite
        }
        
        // Tambahkan aksi pada tombol favorite
        @IBAction func favoriteButtonTapped(_ sender: UIButton) {
            isFavorite.toggle() // Mengubah status favorite
            updateFavoriteButton() // Memperbarui tampilan
            // Lakukan tindakan tambahan, seperti menyimpan perubahan status favorite
        }
    }
