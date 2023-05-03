//
//  AnalysisViewModel.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

import RxSwift
import RxRelay

final class AnalysisViewModel: ViewModelType {
    
    weak var coordinator: MainCoordinator?
    
    let isOpen = BehaviorRelay(value: false)
    
    init(coordinator: MainCoordinator) {
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
