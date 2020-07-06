//
//  AddTimetableRowCellView.swift
//  Big eye
//
//  Created by Const. on 05.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class AddTimetableRowCellView: UIView {
    
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
        translatesAutoresizingMaskIntoConstraints = false
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
            gradient.centerYAnchor.constraint(equalTo: centerYAnchor),
            gradient.centerXAnchor.constraint(equalTo: centerXAnchor),
            gradient.widthAnchor.constraint(equalTo: widthAnchor),
            gradient.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus")
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: gradient.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: gradient.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: gradient.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
}
