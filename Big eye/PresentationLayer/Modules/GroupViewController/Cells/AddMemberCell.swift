//
//  AddMemberCell.swift
//  Big eye
//
//  Created by Const. on 03.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class AddMemberCell: UICollectionViewCell {
    
    // MARK: - UI
    
    let gradient = GradientView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
    }
    
    // MARK: - Select
    
    func didSelect() {
        didHighlight()
        didUnhighlight()
    }
    
    func didHighlight() {
        gradient.alpha = 0
    }
    
    func didUnhighlight() {
        UIView.animate(withDuration: 1, animations: {
            self.gradient.alpha = 1
        })
    }
    
    // MARK: - Fill view
    
    private func fill() {
        backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        layer.cornerRadius = 20
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let startColor = UIColor(red: 200/255, green: 240/255, blue: 255/255, alpha: 1)
        
        gradient.configure(startColor: startColor, endColor: .white, startLocation: 0, endLocation: 1, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        gradient.layer.cornerRadius = 20
        
        addSubview(gradient)
        gradient.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: topAnchor),
            gradient.leadingAnchor.constraint(equalTo: leadingAnchor),
            gradient.bottomAnchor.constraint(equalTo: bottomAnchor),
            gradient.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus")
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
