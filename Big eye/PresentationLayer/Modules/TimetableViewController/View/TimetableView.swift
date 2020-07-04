//
//  TimetableView.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class TimetableView: UIView {
   
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
