//
//  CalendarCell.swift
//  Kevin
//
//  Created by heerucan on 2023/05/01.
//

import UIKit

import FSCalendar
import SnapKit

final class CalendarCell: FSCalendarCell {
    
    private let stickerView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
    }
    
    required init!(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        stickerView.frame = bounds
        stickerView.contentMode = .scaleAspectFit
    }
    
    private func setLayout() {
        addSubview(stickerView)
        
        stickerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.height.equalTo(MatrixLiteral.smallSticker)
        }
    }
}
