//
//  NameTextField.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class NameTextField: UIView {
    
    // MARK: - UI Elements
    
    let firstNameTextField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Имя",
                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        field.textColor = .black
        field.keyboardAppearance = .light
        return field
    }()
    
    let lastNameTextField: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(string: "Фамилия",
                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        field.textColor = .black
        field.keyboardAppearance = .light
        return field
    }()
    
    let separationLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
    
    // MARK: - Fill view
    
    private func fill() {
        
        // MARK: - Started settings
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConst: CGFloat = 10
        let trailingConst: CGFloat = -10
        
        
        // MARK: - firstNameTextField
        
        let firstNameView = UIView()
        
        self.addSubview(firstNameView)
        firstNameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameView.topAnchor.constraint(equalTo: self.topAnchor),
            firstNameView.widthAnchor.constraint(equalTo: self.widthAnchor),
            firstNameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
        
        self.addSubview(firstNameTextField)
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstNameTextField.centerYAnchor.constraint(equalTo: firstNameView.centerYAnchor),
            firstNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConst),
            firstNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingConst)
        ])
        
        // MARK: - lastNameTextField
        
        let lastNameView = UIView()
        
        self.addSubview(lastNameView)
        lastNameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastNameView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lastNameView.widthAnchor.constraint(equalTo: self.widthAnchor),
            lastNameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
        
        self.addSubview(lastNameTextField)
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConst),
            lastNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingConst),
            lastNameTextField.centerYAnchor.constraint(equalTo: lastNameView.centerYAnchor)
        ])
        
        // MARK: - SeparationLine
        
        self.addSubview(separationLine)
        separationLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            separationLine.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            separationLine.widthAnchor.constraint(equalTo: self.widthAnchor),
            separationLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
}
