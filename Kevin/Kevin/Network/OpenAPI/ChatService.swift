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
    private let provider: MoyaProvider<ChatAPI>
    
    init(provider: MoyaProvider<ChatAPI>) {
        self.provider = provider
    }
    
    func requestChat(prompt: String) -> Observable<ChatResponseDTO> {
        let message = MessagesDTO(role: "user", content: prompt)
        let request = ChatRequestDTO(model: "gpt-3.5-turbo", messages: [message])
        
        return provider.rx.request(.chat(request: request))
            .asObservable()
            .map(ChatResponseDTO.self)
            .catch { error in
                // Error handling
                print(error.localizedDescription)
                return Observable.error(error)
            }
    }
}
