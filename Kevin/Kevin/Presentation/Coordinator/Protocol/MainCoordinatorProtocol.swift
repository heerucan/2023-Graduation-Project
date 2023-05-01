//
//  MainCoordinatorProtocol.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import Foundation

protocol MainCoordinatorProtocol {
    func showWriteScreen(forDate date: Date)
    func showDetailScreen(for content: String)
    func showAnalysisScreen(for content: String)
    func popRootViewController(toastMessage: String?)
}
