//
//  MarkAttendanceVCView.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class MarkAttendanceVCView: UIView {
    
    let teacher: String
    let subject: String
    
    // MARK: - UI
    
    let datePicker: UIDatePicker = {
       let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return picker
    }()
    
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
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.text = "Посещаемость"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subjectLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTextField: CopyAndPasteDesabledTextField = {
        let field = CopyAndPasteDesabledTextField()
        field.textColor = .black
        field.backgroundColor = UIColor(red: 200/255, green: 240/255, blue: 255/255, alpha: 1)
        field.layer.cornerRadius = 10
        field.keyboardAppearance = .light
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init
    
    init(teacher: String, subject: String) {
        self.teacher = teacher
        self.subject = subject
        super.init(frame: CGRect())
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        teacherLabel.text = teacher
        subjectLabel.text = subject
        
        dateTextField.inputView = datePicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButton))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexSpace, button], animated: true)
        dateTextField.inputAccessoryView = toolBar
        
        let date = Date()
        let result = dateFormatter.string(from: date)
        dateTextField.text = result
    }
    
    @objc func doneButton() {
        endEditing(true)
    }
    
    @objc func dateChanged() {
        dateTextField.text = dateFormatter.string(from: datePicker.date)
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
        
        addSubview(subjectLabel)
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20),
            subjectLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subjectLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        addSubview(teacherLabel)
        
        NSLayoutConstraint.activate([
            teacherLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 10),
            teacherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            teacherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
        
        addSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            dateTextField.topAnchor.constraint(equalTo: teacherLabel.bottomAnchor, constant: 10),
            dateTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            dateTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/3),
            dateTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        
    }
}
