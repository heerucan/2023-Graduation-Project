//
//  NaverRepository.swift
//  Kevin
//
//  Created by heerucan on 2023/05/16.
//

import Foundation

import RxSwift

protocol NaverRepository {
    func requestNaverAnalyze(text: String) -> Observable<NaverResponseDTO>
}
