//
//  NewTimetableView.swift
//  Big eye
//
//  Created by Const. on 05.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class NewTimetableView: UIView {
    
    let header: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        return view
    }()
    
    let headerTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: "Введите название",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.font = UIFont(name: "Avenir-Heavy", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let confirmButton = CustomButton(title: "Сохранить", normalColor: UIColor(red: 200/255, green: 240/255, blue: 255/255, alpha: 1), enabledColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1))
    
    let cancelButton = CustomButton(title: "Отменить", normalColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1), enabledColor: UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1))
    
    // MARK: - Init
    
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        header.roundCorners(corners: [.topLeft, .topRight], radius: 15)
    }
    
    // MARK: - Setup
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    // MARK: - Fill
    
    private func fill() {
        
        addSubview(header)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.topAnchor.constraint(equalTo: topAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        addSubview(headerTextField)
        
        NSLayoutConstraint.activate([
            headerTextField.topAnchor.constraint(equalTo: header.topAnchor, constant: 5),
            headerTextField.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -5),
            headerTextField.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            headerTextField.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10)
        ])
        
        
        
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            confirmButton.heightAnchor.constraint(equalToConstant: 30),
            confirmButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45)
        ])
        
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45)
        ])
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: header.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10)
        ])
        
        
    }
}
