//
//  TimetableCell.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class TimetableCell: UITableViewCell {

    var rowHeight: CGFloat = 75
    
    var timetableView: TimetableCellView?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .white
    }
    
    // MARK: - configure
    
    func configure(model: TimetableModel, rowHeight: CGFloat) {
        self.rowHeight = rowHeight
        if let view = timetableView {view.removeFromSuperview(); timetableView = nil}
        timetableView = TimetableCellView(model: model, rowHeight: rowHeight)
        fill()
    }
    
    // MARK: - Fill view
    
    private func fill() {
        guard let view = timetableView else { return }

        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
    }

    
}
