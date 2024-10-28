//
//  CategoryViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 23/10/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var tableView: UITableView!
    
    var categoryFood: [FeaturedRestaurant] = []
    var item: Category?
    var viewModel = CategoryViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindingData()
        
    }
    func setup() {
        let nib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func bindingData() {
        if let item = item {
            viewModel.fetchRequestData(type: item.name)
        }
        viewModel.foodAppData.asObservable().subscribe(onNext: { [ weak self ] data in
            guard let self = self else { return }
            guard let data = data else { return }
            self.categoryFood = data.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFood.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        let foodItem = categoryFood[indexPath.row]
        cell.configure(with: foodItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            // Ambil data item yang dipilih
            let selectedFood = categoryFood[indexPath.row]
            
            // Inisialisasi DetailFoodViewController
            let vc = DetailFoodViewController()
            vc.item = selectedFood // Mengoper data ke DetailFoodViewController
            
            // Pindah ke halaman DetailFoodViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    
}


