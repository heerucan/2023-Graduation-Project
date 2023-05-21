//
//  DetailViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class DetailViewModel: ViewModelType {
    
    weak var coordinator: MainCoordinator?
    private let disposeBag = DisposeBag()
    
    private let dataRelay = BehaviorRelay<DetailResponse?>(value: nil)
    
    init(coordinator: MainCoordinator,
         data: DetailResponse,
         type: NavigationType
    ) {
        self.coordinator = coordinator
        self.dataRelay.accept(data)
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let detailData: Observable<DetailResponse>
    }
    
    func transform(_ input: Input) -> Output {
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.finish()
            }
            .disposed(by: disposeBag)
        
        let detailData = Observable.just(dataRelay.value)
            .compactMap { $0 }
                
        return Output(
            detailData: detailData
        )
    }
}
