//
//  SettingViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxCocoa

final class SettingViewModel: ViewModelType {
    
    weak var coordinator: SettingCoordinator?
    private let disposeBag = DisposeBag()
    
    private let settingList = Observable<[Setting]>.of(Setting.allCases)
    
    init(coordinator: SettingCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        let backButtonTap: ControlEvent<Void>
        let itemSelected: ControlEvent<IndexPath>
    }
    
    struct Output {
        let settingList: Observable<[Setting]>
    }
    
    func transform(_ input: Input) -> Output {
        
        input.backButtonTap
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.coordinator?.didFinishSetting()
            }
            .disposed(by: disposeBag)
        
        input.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                // TODO: - 선택 어쩌구...
                
            })
            .disposed(by: disposeBag)
                
        return Output(
            settingList: settingList
        )
    }
}
