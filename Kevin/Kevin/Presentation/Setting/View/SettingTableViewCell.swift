//
//  SettingTableViewCell.swift
//  Kevin
//
//  Created by heerucan on 2023/05/22.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    
    let menuLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .kevinFont(type: .regular16)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        contentView.backgroundColor = .background
    }
    
    private func setLayout() {
        contentView.addSubviews([menuLabel])
        
        menuLabel.snp.makeConstraints { make in
            make.directionalVerticalEdges.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(25)
        }
    }
}
