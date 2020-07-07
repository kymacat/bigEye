//
//  TimetableCellView.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol TimetableCellDelegate {
    func markAttendance(teacher: String, subject: String)
}

class TimetableCellView: UIView {
    
    let model: TimetableModel
    let rowHeight: CGFloat
    var delegate: TimetableCellDelegate?
    
    let header: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        return view
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    // MARK: - Init
    
    init(model: TimetableModel, rowHeight: CGFloat) {
        self.model = model
        self.rowHeight = rowHeight
        super.init(frame: CGRect())
        setup()
        fill()
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
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    // MARK: - Fill
    
    private func fill() {

        addSubview(header)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: rowHeight/2)
        ])
        
        headerLabel.text = model.name
        addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10)
        ])
        
        var previous: SubjectView? = nil
        
        for subject in model.subjects {
            let newSubject = SubjectView(with: subject)
            addRow(row: newSubject, previous: previous)
            previous = newSubject
        }
        
    }
    
    private func addRow(row: SubjectView, previous: SubjectView?) {
        addSubview(row)
        row.delegate = self
        if let previousView = previous {
            
            let separationLine = UIView()
            separationLine.translatesAutoresizingMaskIntoConstraints = false
            separationLine.backgroundColor = .lightGray
            
            addSubview(separationLine)
            
            NSLayoutConstraint.activate([
                separationLine.topAnchor.constraint(equalTo: previousView.bottomAnchor),
                separationLine.leadingAnchor.constraint(equalTo: previousView.leadingAnchor),
                separationLine.trailingAnchor.constraint(equalTo: previousView.trailingAnchor),
                separationLine.heightAnchor.constraint(equalToConstant: 1)
            ])
    
            NSLayoutConstraint.activate([
                row.topAnchor.constraint(equalTo: previousView.bottomAnchor),
                row.leadingAnchor.constraint(equalTo: previousView.leadingAnchor),
                row.trailingAnchor.constraint(equalTo: previousView.trailingAnchor),
                row.heightAnchor.constraint(equalToConstant: rowHeight)
            ])
            
        } else {
            
            NSLayoutConstraint.activate([
                row.topAnchor.constraint(equalTo: header.bottomAnchor),
                row.leadingAnchor.constraint(equalTo: header.leadingAnchor),
                row.trailingAnchor.constraint(equalTo: header.trailingAnchor),
                row.heightAnchor.constraint(equalToConstant: rowHeight)
            ])
            
        }
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension TimetableCellView: SubjectViewDelegate {
    
    func markAttendance(teacher: String, subject: String) {
        delegate?.markAttendance(teacher: teacher, subject: subject)
    }
    
}
