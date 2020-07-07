//
//  TimetableCellRowView.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol SubjectViewDelegate {
    func markAttendance(teacher: String, subject: String)
}

class SubjectView: UIView {
    
    let row: TimetableRowModel
    var delegate: SubjectViewDelegate?
    
    // MARK: - UI
    
    let startTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = label.font.withSize(17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let endTime: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subjectName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = label.font.withSize(17)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teacher: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = label.font.withSize(15)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainButton: UIButton = {
       let button = UIButton()
        button.addTarget(self, action: #selector(mainButtonTouched), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init
    
    init(with row: TimetableRowModel) {
        self.row = row
        super.init(frame: CGRect())
        fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func mainButtonTouched() {
        backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        UIView.animate(withDuration: 0.5, animations: {
            self.backgroundColor = .clear
        })
        
        guard let teacher = teacher.text, let subject = subjectName.text
            else { return }
        
        delegate?.markAttendance(teacher: teacher, subject: subject)
    }
    
    
    // MARK: - Fill
    
    private func fill() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(startTime)
        
        startTime.text = row.startTime
        NSLayoutConstraint.activate([
            startTime.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            startTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            startTime.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/7)
        ])
        
        addSubview(subjectName)
        
        subjectName.text = row.subjectNeme
        NSLayoutConstraint.activate([
            subjectName.topAnchor.constraint(equalTo: startTime.topAnchor),
            subjectName.leadingAnchor.constraint(equalTo: startTime.trailingAnchor, constant: 5),
            subjectName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        addSubview(endTime)
        
        endTime.text = row.endTime
        NSLayoutConstraint.activate([
            endTime.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 5),
            endTime.leadingAnchor.constraint(equalTo: startTime.leadingAnchor)
        ])
        
        
        
        addSubview(teacher)
        
        teacher.text = row.teacher
        NSLayoutConstraint.activate([
            teacher.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 5),
            teacher.leadingAnchor.constraint(equalTo: subjectName.leadingAnchor)
        ])
        
        addSubview(mainButton)
        
        NSLayoutConstraint.activate([
            mainButton.topAnchor.constraint(equalTo: topAnchor),
            mainButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
}
