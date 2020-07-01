//
//  EyeTabBarController.swift
//  Big eye
//
//  Created by Const. on 01.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class EyeTabBarController: UITabBarController {
    var eyeTabBar: EyeTabBar!
    var selectedColor = UIColor(red: 135/255, green: 135/255, blue: 255/255, alpha: 1)
    var normalColor = UIColor.gray {
        didSet {
            eyeTabBar.tintColor = normalColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setupView()
    }

    func setupView() {}

    func setTabBar(items: [EyeTabBarItem]) {
        guard items.count > 0 else { return }

        eyeTabBar = EyeTabBar(items: items)
        guard let bar = eyeTabBar else { return }
        eyeTabBar.tintColor = normalColor
        bar.eyeItems.first?.color = selectedColor
        bar.eyeItems.first?.highlightConstraints()
        
        view.addSubview(bar)
        
        NSLayoutConstraint.activate([
            bar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bar.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        for i in 0 ..< items.count {
            items[i].tag = i
            items[i].addTarget(self, action: #selector(switchTab), for: .touchUpInside)
        }
    }

    @objc func switchTab(button: UIButton) {
        let newIndex = button.tag
        changeTab(from: selectedIndex, to: newIndex)
        selectedIndex = newIndex
    }
    
     private func changeTab(from fromIndex: Int, to toIndex: Int) {
        eyeTabBar.eyeItems[fromIndex].color = normalColor
        eyeTabBar.eyeItems[fromIndex].animateNotHighlight()
        eyeTabBar.eyeItems[toIndex].color = selectedColor
        eyeTabBar.eyeItems[toIndex].animateHighlight()
    }
}
