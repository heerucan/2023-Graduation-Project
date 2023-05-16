//
//  NaverRepositoryImpl.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import RxSwift

final class NaverRepositoryImpl: NaverRepository {
    func requestNaverAnalyze(text: String) -> Observable<NaverResponseDTO> {
        let observable = Observable<NaverResponseDTO>.create { observer -> Disposable in
            return Disposables.create()
        }
        return observable
    }
}
