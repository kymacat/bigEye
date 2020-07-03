//
//  NewMemberView.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class NewMemberView: UIView {
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setImage")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let firstAndLastNames = NameTextField()
    
    let extraInfoTextField: UITextView = {
        let view = UITextView()
        view.backgroundColor = .white
        view.textColor = .black
        view.keyboardAppearance = .light
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.text = "Дополнительная информация"
        view.textAlignment = .center
        view.textColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let confirmButton = CustomButton(title: "Добавить", normalColor: UIColor(red: 200/255, green: 240/255, blue: 255/255, alpha: 1), enabledColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1))
    
    let cancelButton = CustomButton(title: "Отменить", normalColor: UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1), enabledColor: UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1))
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 15
        
        firstAndLastNames.firstNameTextField.delegate = self
        firstAndLastNames.lastNameTextField.delegate = self
        
        confirmButton.isEnabled = false
        
        extraInfoTextField.font = firstAndLastNames.firstNameTextField.font
        extraInfoTextField.delegate = self
    }
    
    // MARK: - Fill view
    
    private func fill() {
        
        addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            avatarImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ])
        
        addSubview(firstAndLastNames)
        
        NSLayoutConstraint.activate([
            firstAndLastNames.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            firstAndLastNames.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            firstAndLastNames.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            firstAndLastNames.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        
        addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            confirmButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            confirmButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.43),
            confirmButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.12)
        ])
        
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cancelButton.bottomAnchor.constraint(equalTo: confirmButton.bottomAnchor),
            cancelButton.widthAnchor.constraint(equalTo: confirmButton.widthAnchor),
            cancelButton.heightAnchor.constraint(equalTo: confirmButton.heightAnchor)
        ])
        
        addSubview(extraInfoTextField)
        
        NSLayoutConstraint.activate([
            extraInfoTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            extraInfoTextField.leadingAnchor.constraint(equalTo: confirmButton.leadingAnchor),
            extraInfoTextField.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            extraInfoTextField.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width/2
    }
}

// MARK: - TextViewDelegate

extension NewMemberView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.gray {
            textView.text = nil
            textView.textAlignment = .left
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Дополнительная информация"
            textView.textColor = UIColor.gray
            textView.textAlignment = .center
        }
    }
    
}

// MARK: - TextFieldDelegate

extension NewMemberView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard
            let firstName = firstAndLastNames.firstNameTextField.text,
            let lastName = firstAndLastNames.lastNameTextField.text else {
                return
        }
        if firstName != "" && lastName != "" {
            confirmButton.isEnabled = true
        } else {
            confirmButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
}