//
//  ChatUseCase.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import RxSwift

protocol ChatUseCase {
    func requestChat(content: String)
}

final class ChatUseCaseImpl: ChatUseCase {
    
    private let repository: ChatRepository
    private let bag = DisposeBag()
    
    var chatResponse = PublishSubject<ChatResponseDTO>()
    var chatFail = PublishSubject<Error>()
    
    init(repository: ChatRepository = ChatRepositoryImpl()) {
        self.repository = repository
    }
    
    func requestChat(content: String) {
        return repository.requestChat(content: content)
            .subscribe(onNext: { [weak self] response in
                // ChatResponseDTO를 사용하여 필요한 작업 수행
                print(response)
                self?.chatResponse.onNext(response)
            }, onError: { error in
                // 에러 처리
                print(error)
                self.chatFail.onNext(error)
            })
            .disposed(by: bag)
    }
}
