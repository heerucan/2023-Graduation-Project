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
    private let provider: MoyaProvider<NaverAPI>
    
    init(provider: MoyaProvider<NaverAPI>) {
        self.provider = provider
    }
    
    func requestNaverAnalyze(text: String) -> Observable<NaverResponseDTO> {
        let text = NaverRequestDTO(content: text)
        
        return provider.rx.request(.analyze(text: text))
            .asObservable()
            .map(NaverResponseDTO.self)
            .catch { error in
                // Error handling
                print(error.localizedDescription)
                return Observable.error(error)
            }
    }
}
