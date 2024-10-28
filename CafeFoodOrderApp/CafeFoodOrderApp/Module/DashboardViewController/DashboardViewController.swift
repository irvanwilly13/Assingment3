//
//  DashboardViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 21/10/24.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa
import RxRelay

enum FoodDashboardType: Int, CaseIterable {
    case foodCategory = 0
    case featuredRestaurant
    case popularItem
}

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = DashboardViewModel()
    let profileViewModel = ProfileViewModel() // Tambahkan ProfileViewModel untuk mendapatkan data profil

    let disposeBag = DisposeBag()
    
    var foodsData: [Category] = []
    var featuredRestaurant: [FeaturedRestaurant] = []
    var popularItems: [FeaturedRestaurant] = []
    
    var userName: String?
        var userEmail: String?
        var userImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        hideNavigationBar()
        bindingData()
        loadProfileData()
        
    }
    func loadProfileData() {
            profileViewModel.profileDataModel.asObservable().subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                guard let profileData = item?.data else { return }
                self.userName = profileData.fullName
                self.userEmail = profileData.email
                self.userImage = UIImage(named: profileData.profileImageURL) // Pastikan ini adalah image lokal atau unduh jika dari URL
            }).disposed(by: disposeBag)
            
            profileViewModel.fetchRequestData()
        }
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [ weak self ] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.tableView.showAnimatedGradientSkeleton()
                case .failed:
                    print("failed")
                    self.tableView.hideSkeleton()
                case .finished:
                    self.tableView.hideSkeleton()
                    print("finished")
                default:
                    break
                }
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.foodAppData.asObservable().subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }
            self.foodsData = data.categories
            self.featuredRestaurant = data.featuredRestaurants
            self.popularItems = data.popularItems
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        } ).disposed(by: disposeBag)
        viewModel.fetchRequestData()
    }
    
    
    func setup() {
        optionButton.addTarget(self, action: #selector(openLeftMenu), for: .touchUpInside)
        
        let nib = UINib(nibName: "FoodCategoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FoodCategoryTableViewCell")
        let nibDetail = UINib(nibName: "FoodDetailTableViewCell", bundle: nil)
        tableView.register(nibDetail, forCellReuseIdentifier: "FoodDetailTableViewCell")
        let nibRestaurant = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.register(nibRestaurant, forCellReuseIdentifier: "RestaurantTableViewCell")
        let nibPopular = UINib(nibName: "PopularItemTableViewCell", bundle: nil)
        tableView.register(nibPopular, forCellReuseIdentifier: "PopularItemTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    @objc func openLeftMenu() {
        let leftMenuVC = LeftMenuBottomSheetViewController()
        let navController = UINavigationController(rootViewController: leftMenuVC)
        navController.modalPresentationStyle = .overFullScreen
        present(navController, animated: true, completion: nil)
    }
    func hideNavigationBar() {
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.isTranslucent = false
        //self.hidesBottomBarWhenPushed = false
    }
    
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return FoodDashboardType.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = FoodDashboardType(rawValue: section)
        switch sectionType {
        case .foodCategory:
            return 1
        case .featuredRestaurant:
            return 1
        case.popularItem:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = FoodDashboardType(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch sectionType {
        case .foodCategory:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCategoryTableViewCell", for: indexPath) as? FoodCategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.categoryItems = foodsData
            cell.onSelectCategory = { [weak self] category in
                guard let self = self else { return }
                self.navigateToCategory(item: category)
            }
            return cell

            
        case .featuredRestaurant:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell", for: indexPath) as? RestaurantTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: featuredRestaurant)
            return cell

        case .popularItem:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularItemTableViewCell", for: indexPath) as? PopularItemTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: popularItems)
            return cell
        }
    }
    
    func navigateToCategory(item: Category) {
    let vc = CategoryViewController()
    vc.item = item
    
    vc.hidesBottomBarWhenPushed = false
    self.navigationController?.pushViewController(vc, animated: true)
}
}
