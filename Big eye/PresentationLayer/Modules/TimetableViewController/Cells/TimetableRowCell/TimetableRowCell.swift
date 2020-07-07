//
//  TimetableRowCell.swift
//  Big eye
//
//  Created by Const. on 05.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class TimetableRowCell: UITableViewCell {

    var rowView: SubjectView?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
    }
    
    func configure(with row: TimetableRowModel) {
        rowView = SubjectView(with: row)
        fill()
    }
    
    // MARK: - Fill
    
    private func fill() {
        guard let view = rowView else {
            return
        }
        
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
