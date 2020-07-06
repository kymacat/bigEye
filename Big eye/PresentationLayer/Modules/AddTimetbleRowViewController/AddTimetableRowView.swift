//
//  AddTimetableRowView.swift
//  Big eye
//
//  Created by Const. on 06.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class AddTimetableRowView: UIView {
    
    // MARK: - UI
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Avenir-Heavy", size: 22)
        label.text = "Добавить"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let doubleTextField = DoubleTextField(firstPlaceholder: "Название предмета", secondPlaceholder: "Имя преподавателя")
    
    let timePickerView: UIPickerView = {
       let pickerView = UIPickerView()
        pickerView.backgroundColor = .white
        pickerView.tintColor = .black
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.text = "Время начала - 0:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.text = "Время окончания - 0:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        doubleTextField.firstTextField.delegate = self
        doubleTextField.secondTextField.delegate = self
        
        let hideKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabGesture))
        addGestureRecognizer(hideKeyboardRecognizer)
        
    }
    
    @objc func tabGesture() {
        endEditing(true)
    }
    
    // MARK: - Fill
    
    private func fill() {
        
        let header = UIView()
        header.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        header.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/13)
        ])
        
        let separationLine = UIView()
        separationLine.backgroundColor = .lightGray
        separationLine.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(separationLine)
        
        NSLayoutConstraint.activate([
            separationLine.topAnchor.constraint(equalTo: header.bottomAnchor),
            separationLine.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            separationLine.trailingAnchor.constraint(equalTo: header.trailingAnchor),
            separationLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        header.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10),
            cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            cancelButton.heightAnchor.constraint(equalTo: header.heightAnchor, multiplier: 1/2)
        ])
        
        header.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            saveButton.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            saveButton.heightAnchor.constraint(equalTo: header.heightAnchor, multiplier: 1/2)
        ])
        
        header.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: header.centerXAnchor)
        ])
        
        addSubview(doubleTextField)
        
        NSLayoutConstraint.activate([
            doubleTextField.topAnchor.constraint(equalTo: separationLine.bottomAnchor, constant: 20),
            doubleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            doubleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            doubleTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/9)
        ])
        
        addSubview(timePickerView)
        
        NSLayoutConstraint.activate([
            timePickerView.topAnchor.constraint(equalTo: doubleTextField.bottomAnchor),
            timePickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            timePickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            timePickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/5)
        ])
    
        
        addSubview(startTimeLabel)
        
        NSLayoutConstraint.activate([
            startTimeLabel.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 10),
            startTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(endTimeLabel)
        
        NSLayoutConstraint.activate([
            endTimeLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 10),
            endTimeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
}

// MARK: - TextFieldDelegate

extension AddTimetableRowView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
}
