//
//  KevinImageButton.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

final class KevinImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        var titleAttribute = AttributedString.init(StringLiteral.Button.listen)
        titleAttribute.font = .kevinFont(type: .medium14)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = Image.retry
        configuration.imagePlacement = .leading
        configuration.imagePadding = -6
        configuration.baseForegroundColor = .black
        configuration.attributedTitle = titleAttribute
        self.configuration = configuration
        
        self.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            switch button.state {
            case .highlighted:
                configuration.baseForegroundColor = .gray200
                configuration.image = Image.retry.withTintColor(
                    .gray200, renderingMode: .alwaysOriginal)
                self.configuration = configuration
            default:
                configuration.baseForegroundColor = .black
                configuration.image = Image.retry.withTintColor(
                    .black, renderingMode: .alwaysOriginal)
                self.configuration = configuration
            }
        }
    }
}
