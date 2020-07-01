//
//  GroupVCView.swift
//  Big eye
//
//  Created by Const. on 01.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class GroupVCView: UIView {
    
    let collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView

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
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -45),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
}
