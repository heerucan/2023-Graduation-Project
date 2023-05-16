//
//  NaverUseCase.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import RxSwift

protocol NaverUseCase {
    func requestNaverAnalyze(text: String) -> Observable<NaverResponseDTO>
}

final class NaverUseCaseImpl: NaverUseCase {
    
    private let repository: NaverRepository
    
    init(repository: NaverRepository = NaverRepositoryImpl()) {
        self.repository = repository
    }
    
    func requestNaverAnalyze(text: String) -> RxSwift.Observable<NaverResponseDTO> {
        repository.requestNaverAnalyze(text: text)
    }
}
