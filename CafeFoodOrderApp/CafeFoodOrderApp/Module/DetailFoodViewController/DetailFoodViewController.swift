//
//  DetailFoodViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit

class DetailFoodViewController: UIViewController {
    
    var item: FeaturedRestaurant?
    var itemCount: Int = 1
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var seeReviewButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var addToChartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        
        
    }
    func setup() {
        addToChartButton.addTarget(self, action: #selector(actionTap), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseItemCount), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(decreaseItemCount), for: .touchUpInside)
    }
    func loadData() {
        if let item = item {
            nameLabel.text = item.name
            imgView.image = UIImage(named: item.image)
            descLabel.text = item.description
            priceLabel.text = String(format: "%.2f", item.price ?? 0)
            ratingLabel.text = String(format: "%.1f", item.rating)
            countLabel.text = "\(itemCount)" // Default item count
        }
    }
    
    @objc func actionTap() {
        if let foodItem = self.item {
            CartService.shared.addToCart(food: foodItem)
            navigateToDashboard()
            
            
        }
    }
    @objc func increaseItemCount() {
        itemCount += 1
        countLabel.text = "\(itemCount)"
    }
    @objc func decreaseItemCount() {
        if itemCount > 1 {
            itemCount -= 1
            countLabel.text = "\(itemCount)"
        }
    }
    func navigateToDashboard() {
        let vc = DashboardViewController()
       // vc.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
