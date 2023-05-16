//
//  NaverService.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import Moya
import RxMoya
import RxSwift

final class NaverService {
    static let shared = NaverService()
    private init() { }
    private let provider = MoyaProvider<NaverAPI>()
    private let disposeBag = DisposeBag()
    
    func requestNaverAnalysis(text: String) -> Observable<NaverResponseDTO> {
        
        let text = NaverRequestDTO(content: text)
        
        return Observable<NaverResponseDTO>.create { observer in
            self.provider.rx.request(.analyze(text: text))
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        do {
                            let body = try response.map(NaverResponseDTO.self)
                            observer.onNext(body)
                            observer.onCompleted()
                        } catch let error {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
