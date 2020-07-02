//
//  GroupMemberCell.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

struct GroupMemberCellModel {
    let imageName: String
    let firstName: String
    let lastName: String
    let description: String
}

class GroupMemberCell: UICollectionViewCell {
    
    // MARK: - UI
    
    let imageView = UIImageView()
    
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    // MARK: - Configure
    
    func configure(with model: GroupMemberCellModel) {
        imageView.image = UIImage(named: model.imageName)
        firstNameLabel.text = model.firstName
        lastNameLabel.text = model.lastName
    }
    
    let normalColor = UIColor.white
    let highlightedColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    
    func didSelect() {
        didHighlight()
        UIView.animate(withDuration: 1, animations: {
            self.didUnhighlight()
        })
    }
    
    func didHighlight() {
        backgroundColor = highlightedColor
    }
    
    func didUnhighlight() {
        backgroundColor = normalColor
    }
    
    // MARK: - Fill view
    private func fill() {
        backgroundColor = normalColor
        layer.cornerRadius = 20
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 31
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        addSubview(firstNameLabel)
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            firstNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            firstNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
        
        addSubview(lastNameLabel)
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 2),
            lastNameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            lastNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
