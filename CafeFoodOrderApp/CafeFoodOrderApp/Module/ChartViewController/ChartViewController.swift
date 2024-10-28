//
//  ChartViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit

class ChartViewController: UIViewController {

    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var voucherField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var checkOutButton: UIButton!
    
    private var cartItems: [(food: FeaturedRestaurant, quantity: Int)] = []
    var taxRate: Double = 10.0
    var deliveryFee: Double = 15000.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadCartItem()
        hideNavigationBar()

    }
    func setup() {
        let nib = UINib(nibName: "ChartViewTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ChartViewTableViewCell")
        
        checkOutButton.addTarget(self, action: #selector(actionToCheckOut), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    @objc func actionToCheckOut() {
        let vc = PaymentViewController()
        vc.totalAmount = totalLabel.text // Kirim nilai totalLabel ke PaymentViewController

        self.navigationController?.pushViewController(vc, animated: true)

    }
    func loadCartItem() {
        cartItems = CartService.shared.getCartItem()
        tableView.reloadData()
        updateTotalPrice()
    }
    func updateTotalPrice() {
        let subtotal = cartItems.reduce(0) { $0 + (Double($1.quantity) * ($1.food.price ?? 0)) }
                let tax = subtotal * taxRate
                let total = subtotal + tax + deliveryFee
                
                subTotalLabel.text = String(format: "Rp. %.2f", subtotal)
                taxLabel.text = String(format: "Rp. %.2f", tax)
                totalLabel.text = String(format: "Rp. %.2f", total)
                deliveryFeeLabel.text = String(format: "Rp. %.2f", deliveryFee)
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = true
        self.hidesBottomBarWhenPushed = false
    }

    

}

extension ChartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartViewTableViewCell", for: indexPath) as? ChartViewTableViewCell
        if cell == nil {
            return UITableViewCell()
        }
        
        let item = cartItems[indexPath.row]
        cell?.configure(with: item.food, quantity: item.quantity)
        cell?.delegate = self
        return cell!
    }
}

extension ChartViewController: FoodChartItemTableViewCellDelegate {
    func cartItemCell(didTapAddFor food: FeaturedRestaurant) {
        CartService.shared.addToCart(food: food)
        loadCartItem()
        updateTotalPrice()
    }
    
    func cartItemCell(didtapRemoveFor food: FeaturedRestaurant) {
        CartService.shared.removeFromCart(food: food)
        loadCartItem()
        updateTotalPrice()
    }
}


