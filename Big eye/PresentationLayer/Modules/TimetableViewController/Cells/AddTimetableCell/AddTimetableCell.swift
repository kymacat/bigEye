//
//  AddCell.swift
//  Big eye
//
//  Created by Const. on 05.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class AddTimetableCell: UITableViewCell {
    
    // MARK: - UI
    
    let cellView = AddTimetableCellView()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
    
    // MARK: - Select
    
    func didSelect() {
        cellView.didHighlight()
        cellView.didUnhighlight()
    }
    
    func didHighlight() {
        cellView.didHighlight()
    }
    
    func didUnhighlight() {
        cellView.didUnhighlight()
    }
    
    // MARK: - Fill view
    
    private func fill() {
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            cellView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
        
        
    }

    
}
