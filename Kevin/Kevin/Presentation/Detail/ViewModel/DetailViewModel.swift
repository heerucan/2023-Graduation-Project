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
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.finish()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
