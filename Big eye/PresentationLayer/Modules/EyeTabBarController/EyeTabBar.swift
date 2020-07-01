//
//  EyeTabBar.swift
//  Big eye
//
//  Created by Const. on 01.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class EyeTabBar: UITabBar {
    
    var eyeItems = [EyeTabBarItem]()
    
    convenience init(items: [EyeTabBarItem]) {
        self.init()
        self.eyeItems = items
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    override var tintColor: UIColor! {
        didSet {
            for item in eyeItems {
                item.color = tintColor
            }
        }
    }

    func setupView() {
        barTintColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        if eyeItems.count == 0 { return }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 75
        
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let line = UIView()
        line.backgroundColor = .lightGray
        
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.bottomAnchor.constraint(equalTo: topAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        
        for item in eyeItems {
            stackView.addArrangedSubview(item)
        }

    }
}
