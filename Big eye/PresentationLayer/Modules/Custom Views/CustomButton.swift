//
//  CustomButton.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - Init
    
    init(title: String, normalColor: UIColor, enabledColor: UIColor) {
        self.normalColor = normalColor
        self.enabledColor = enabledColor
        super.init(frame: CGRect())
        setupButton(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupButton(with title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = normalColor
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
    }
    
    // MARK: - Events
    
    let normalColor: UIColor
    let enabledColor: UIColor
    
    override var isEnabled: Bool {
        didSet {
            guard oldValue != isEnabled else {
                return
            }
            if oldValue == true {
                buttonTouchedIn(with: 0.3)
            } else {
                buttonTouchedOut(with: 0.3)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if oldValue != isHighlighted {
                updateAppearance()
            }
        }
    }
    
    private func updateAppearance() {
      if (isSelected || isHighlighted) && isEnabled {
        buttonTouchedIn(with: 0.05)
      } else {
        buttonTouchedOut(with: 0.05)
      }
    }
    
    private func buttonTouchedIn(with duration: Double) {
      UIView.animate(withDuration: duration, animations: {
        self.backgroundColor = self.enabledColor
      })
    }
    
    private func buttonTouchedOut(with duration: Double) {
      UIView.animate(withDuration: duration, animations: {
        self.backgroundColor = self.normalColor
      })
    }
    
}
