//
//  DoubleTextField.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class DoubleTextField: UIView {
    
    // MARK: - UI Elements
    
    let firstTextField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.keyboardAppearance = .light
        return field
    }()
    
    let secondTextField: UITextField = {
        let field = UITextField()
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
    
    init(firstPlaceholder: String, secondPlaceholder: String) {
        super.init(frame: CGRect())
        fill(firstPlaceholder: firstPlaceholder, secondPlaceholder: secondPlaceholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Fill view
    
    private func fill(firstPlaceholder: String, secondPlaceholder: String) {
        
        // MARK: - Started settings
        
        firstTextField.attributedPlaceholder = NSAttributedString(string: firstPlaceholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        secondTextField.attributedPlaceholder = NSAttributedString(string: secondPlaceholder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
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
        
        self.addSubview(firstTextField)
        firstTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstTextField.centerYAnchor.constraint(equalTo: firstNameView.centerYAnchor),
            firstTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConst),
            firstTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingConst)
        ])
        
        // MARK: - secondTextField
        
        let lastNameView = UIView()
        
        self.addSubview(lastNameView)
        lastNameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            lastNameView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lastNameView.widthAnchor.constraint(equalTo: self.widthAnchor),
            lastNameView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
        
        self.addSubview(secondTextField)
        secondTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            secondTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingConst),
            secondTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingConst),
            secondTextField.centerYAnchor.constraint(equalTo: lastNameView.centerYAnchor)
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
