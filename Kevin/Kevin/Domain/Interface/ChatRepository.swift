//
//  ChatRepository.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import RxSwift

protocol ChatRepository {
    func requestChat(content: String) -> Observable<ChatResponseDTO>
}
