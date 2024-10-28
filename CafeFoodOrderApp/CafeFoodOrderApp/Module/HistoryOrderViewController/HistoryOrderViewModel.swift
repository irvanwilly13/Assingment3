//
//  HistoryOrderViewModel.swift
//  CafeFoodOrderApp
//
//  Created by Muhammad Farrel Al Fathir on 25/10/24.
//


import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HistoryOrderViewModel: BaseViewModel {
    
    var networkManager = NetworkManager.shared

    var historyDataModel = BehaviorRelay<HistoryModel?>(value: nil)
    var disposeBag = DisposeBag()
    
    func fetchRequestData() {
        self.loadingState.accept(.loading)
        NetworkManager.shared.fetchRequest(endpoint: .getAllHistory, epecting: HistoryModel.self) { result in
            switch result {
            case .success(let data):
                print("items berhasil diambil: \(data)")
                self .loadingState.accept(.finished)
                self .historyDataModel.accept(data)
            case .failure(let error):
                print("Terjadi error: \(error)")
                self .loadingState.accept(.failed)
            }
            
        }
    }
}
