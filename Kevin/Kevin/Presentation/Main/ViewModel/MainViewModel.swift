//
//  MainViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class MainViewModel: ViewModelType {
    
    weak var coordinator: MainCoordinator?
    private let disposeBag = DisposeBag()
    
    var selectedDate = PublishRelay<Date>()
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let settingButtonDidTap: ControlEvent<Void>
        let calendarDidSelected: Observable<Date>
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        let output = Output()
        
        input.settingButtonDidTap
            .subscribe { [weak self] _ in
                guard let self else { return }
                self.coordinator?.showSettingFlow()
            }
            .disposed(by: disposeBag)
        
        input.calendarDidSelected
            .subscribe { [weak self] date in
                guard let self else { return }
                self.coordinator?.showWriteScreen(forDate: date)
            }
            .disposed(by: disposeBag)
        
        return output
    }
}
