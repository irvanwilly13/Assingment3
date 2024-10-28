//
//  PopularItemTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import UIKit

class PopularItemTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var popularData: [FeaturedRestaurant] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        
    }
    func setup() {
        let nib = UINib(nibName: "PopularItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PopularItemCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(with popularItems: [FeaturedRestaurant]) {
            // Atur tampilan item populer di sini
        self.popularData = popularItems
        }
    
}

extension PopularItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularItemCollectionViewCell", for: indexPath) as?  PopularItemCollectionViewCell
        cell?.setup(item: popularData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 2) - 10, height: 220)
    }
    
    
}
