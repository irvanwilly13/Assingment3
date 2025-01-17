//
//  FoodCategoryTableViewCell.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit

class FoodCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categoryItems: [Category] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    var onSelectCategory: ((_ category: Category) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setup() {
        let nib = UINib(nibName: "FoodCategoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "FoodCategoryCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    func configure(with categories: [Category]) {
        // Atur tampilan kategori makanan di sini
        self.categoryItems = categories
        collectionView.reloadData()
        
    }
    
}
extension FoodCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCollectionViewCell", for: indexPath) as?  FoodCategoryCollectionViewCell
        cell?.setup(item: categoryItems[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: (screenWidth / 3.5) - 10, height: 128)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedCategory = categoryItems[indexPath.row]
            onSelectCategory?(selectedCategory)
        }
    
    
}
