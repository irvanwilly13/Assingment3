//
//  ProfileViewController.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 22/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SkeletonView

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var toolBarView: ToolBarView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var changePictureButton: UIButton!
    @IBOutlet weak var changePhoneButton: UIButton!
    @IBOutlet weak var changeUsernameButton: UIButton!
    
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var viewModel = ProfileViewModel()
    var disposeBag = DisposeBag()
    var profileData: [DataProfileUser] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindingData()
        viewModel.fetchRequestData()
        setupImageView()

        
        
    }
    func configure(data: DataProfileUser) {
        DispatchQueue.main.async {
            self.imgView.image = UIImage(named: data.profileImageURL)
            self.nameLabel.text = data.fullName
            self.emailLabel.text = data.email
            self.phoneLabel.text = data.phoneNumber
            self.birthLabel.text = data.dateOfBirth
            self.genderLabel.text = data.gender
            self.streetLabel.text = data.address.street
            self.cityLabel.text = data.address.city
            self.stateLabel.text = data.address.state
            self.zipcodeLabel.text = data.address.zipCode
            self.countryLabel.text = data.address.country
        }
    }
    func setupImageView() {
        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.layer.masksToBounds = true
    }
    func bindingData() {
        viewModel.loadingState.asObservable().subscribe(onNext: { [weak self] loading in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch loading {
                case .loading:
                    print("loading")
                    self.view.showAnimatedGradientSkeleton()
                case .failed:
                    print("failed")
                    self.view.hideSkeleton()
                case .finished:
                    self.view.hideSkeleton()
                    print("finished")
                default:
                    break
                }
            }
            
        }).disposed(by: disposeBag)
        
        viewModel.profileDataModel.asObservable().subscribe(onNext: { [weak self] item in
                    guard let self = self else { return }
                    guard let profileData = item?.data else { return }
                    self.configure(data: profileData)
                }).disposed(by: disposeBag)
        
        viewModel.fetchRequestData()
    }
//    @objc func openLeftMenu() {
//            let leftMenuVC = LeftMenuBottomSheetViewController()
//            leftMenuVC.userName = nameLabel.text
//            leftMenuVC.userEmail = emailLabel.text
//            leftMenuVC.userImage = imgView.image
//            
//            leftMenuVC.modalPresentationStyle = .overFullScreen
//            leftMenuVC.modalTransitionStyle = .crossDissolve
//            present(leftMenuVC, animated: true, completion: nil)
//        }
    
    
}
