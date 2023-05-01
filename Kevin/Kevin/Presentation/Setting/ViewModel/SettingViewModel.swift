//
//  SettingViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift

final class SettingViewModel: ViewModelType {
    
    weak var coordinator: SettingCoordinator?
    
    init(coordinator: SettingCoordinator) {
        self.coordinator = coordinator
    }
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        let output = Output()
        return output
    }
}
