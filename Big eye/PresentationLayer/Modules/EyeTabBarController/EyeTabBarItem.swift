//
//  tabBarItem.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class EyeTabBarItem: UIButton {
    
    // MARK: - UI
    
    private var highlightingConstraint = [NSLayoutConstraint]()
    private var notHighlightingConstraint = [NSLayoutConstraint]()
    
    
    var color: UIColor = UIColor.lightGray {
        didSet {
            iconImageView.tintColor = color
            textLabel.textColor = color
            line.backgroundColor = color
        }
    }
    
    private let iconImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let line: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Init
    
    convenience init(iconName: String, title: String) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        textLabel.text = title
        setupView()
    }

   // MARK: - SetupView
    
    private func setupView() {

        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor)
        ])
        
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(line)
        
        highlightingConstraint = [
            line.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor)
        ]
        
        notHighlightingConstraint = [
            line.leadingAnchor.constraint(equalTo: centerXAnchor),
            line.trailingAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(notHighlightingConstraint)
        
        NSLayoutConstraint.activate([
            line.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            line.heightAnchor.constraint(equalToConstant: 2)
        ])
        
    }
    
    // MARK: - Line animation
    
    func animateHighlight() {
        UIView.animate(withDuration: 0.7, animations: {
            self.highlightConstraints()
            self.layoutIfNeeded()
        })
    }
    
    func animateNotHighlight() {
        UIView.animate(withDuration: 0.7, animations: {
            self.notHighlightConstraints()
            self.layoutIfNeeded()
        })
    }
    
    func highlightConstraints() {
        NSLayoutConstraint.deactivate(notHighlightingConstraint)
        NSLayoutConstraint.activate(highlightingConstraint)
    }
    
    func notHighlightConstraints() {
        NSLayoutConstraint.deactivate(highlightingConstraint)
        NSLayoutConstraint.activate(notHighlightingConstraint)
    }
    
    
}
