//
//  TimetableView.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class TimetableView: UIView {
    
    var addTimetableView = AddTimetableView()
   
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    func showAddTimetableView() {
        let newView = AddTimetableView()
        newView.delegate = addTimetableView.delegate
        addTimetableView = newView
        
        addSubview(addTimetableView)
        
        NSLayoutConstraint.activate([
            addTimetableView.topAnchor.constraint(equalTo: topAnchor),
            addTimetableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            addTimetableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            addTimetableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addTimetableView.layoutIfNeeded()
        
        addTimetableView.showAnimation()
    }
    
    // MARK: - Fill view
    
    private func fill() {
        
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -45),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
}
