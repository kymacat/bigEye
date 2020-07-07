//
//  MarkAttendanceCell.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol MarkAttendanceCellDelegate {
    func changeStatus(firstName: String, lastname: String, with status: Bool)
}


class MarkAttendanceCell: UITableViewCell {
    
    var delegate: MarkAttendanceCellDelegate?
    
    // MARK: - UI
    
    let checkBox = CheckBoxButton()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
        setup()
    }
    
    
    // MARK: - Configure
    
    var model: AttendanceModel?
    
    func configure(with model: AttendanceModel) {
        self.model = model
        checkBox.isChecked = model.isAttended
        nameLabel.text = model.person.lastName + " " + model.person.firstName
    }
    
    // MARK: - Setup
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .white
        checkBox.addTarget(self, action: #selector(changeStatus), for: .touchUpInside)
    }
    
    @objc func changeStatus() {
        guard var currModel = model else {
            return
        }
        currModel.isAttended = checkBox.isChecked
        delegate?.changeStatus(firstName: currModel.person.firstName, lastname: currModel.person.lastName, with: currModel.isAttended)
    }
    
    // MARK: - Fill view
    
    private func fill() {
        addSubview(checkBox)
        
        NSLayoutConstraint.activate([
            checkBox.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            checkBox.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            checkBox.widthAnchor.constraint(equalTo: checkBox.heightAnchor)
        ])
        
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: checkBox.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: checkBox.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }

    
}
