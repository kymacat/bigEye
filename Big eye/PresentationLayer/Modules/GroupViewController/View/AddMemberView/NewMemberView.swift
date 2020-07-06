//
//  NewMemberView.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class NewMemberView: UIView {
    
    let avatarImage: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "setImage"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let firstAndLastNames = DoubleTextField(firstPlaceholder: "Имя", secondPlaceholder: "Фамилия")
    
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
        
        firstAndLastNames.firstTextField.delegate = self
        firstAndLastNames.secondTextField.delegate = self
        
        confirmButton.isEnabled = false
        
        extraInfoTextField.font = firstAndLastNames.firstTextField.font
        extraInfoTextField.delegate = self
    }
    
    // MARK: - Fill view
    
    private func fill() {
        
        addSubview(avatarImage)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            avatarImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor)
        ])
        
        addSubview(firstAndLastNames)
        
        NSLayoutConstraint.activate([
            firstAndLastNames.topAnchor.constraint(equalTo: avatarImage.topAnchor),
            firstAndLastNames.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            firstAndLastNames.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor),
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
            extraInfoTextField.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 10),
            extraInfoTextField.leadingAnchor.constraint(equalTo: confirmButton.leadingAnchor),
            extraInfoTextField.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor),
            extraInfoTextField.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -10)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.bounds.width/2
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
            let firstName = firstAndLastNames.firstTextField.text,
            let lastName = firstAndLastNames.secondTextField.text else {
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
