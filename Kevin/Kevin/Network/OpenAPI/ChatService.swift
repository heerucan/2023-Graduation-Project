//
//  ChatService.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import Moya
import RxMoya
import RxSwift

final class ChatService {
    static let shared = ChatService()
    private init() { }
    private let provider = MoyaProvider<ChatAPI>()
    private let disposeBag = DisposeBag()
    
    func requestChat(content: String) -> Observable<ChatResponseDTO> {
        
        let message = Messages(role: "user", content: content)
        let request = ChatRequestDTO(model: "gpt-3.5-turbo", messages: [message])
        
        return Observable<ChatResponseDTO>.create { observer in
            self.provider.rx.request(.chat(request: request))
                .subscribe { event in
                    switch event {
                    case .success(let response):
                        do {
                            let body = try response.map(ChatResponseDTO.self)
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
