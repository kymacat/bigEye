//
//  AddMemberView.swift
//  Big eye
//
//  Created by Const. on 02.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol AddMemberDelegate {
    func addMember(firstName: String, lastName: String, description: String?, image: UIImage?)
    func setImage()
}

class AddMemberView: UIView {
    
    var delegate: AddMemberDelegate?
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newMemberView = NewMemberView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
        setup()
    }
    
    // MARK: - Animations
    
    private var startedConstraints = [NSLayoutConstraint]()
    private var finalConstraints = [NSLayoutConstraint]()
    private var constraintsWithoutKeyboard = [NSLayoutConstraint]()
    private var constraintsWithKeyboard = [NSLayoutConstraint]()
    
    var isKeyboardShown = false
    var isFinished = false
    
    func setConstraintsWithoutKeyboard() {
        if isFinished {return}
        
        NSLayoutConstraint.deactivate(constraintsWithKeyboard)
        NSLayoutConstraint.activate(constraintsWithoutKeyboard)
        
        UIView.animate(withDuration: 2, animations: {
            self.layoutIfNeeded()
        })
        isKeyboardShown = false
    }
    
    func setConstraintsWithKeyboard() {
        NSLayoutConstraint.deactivate(constraintsWithoutKeyboard)
        NSLayoutConstraint.activate(constraintsWithKeyboard)
        
        UIView.animate(withDuration: 2, animations: {
            self.layoutIfNeeded()
        })
        isKeyboardShown = true
    }
    
    func showAnimation() {
        NSLayoutConstraint.deactivate(startedConstraints)
        NSLayoutConstraint.activate(constraintsWithoutKeyboard)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
            self.shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    
    func removeWithAnimation() {
        let allConstraints = startedConstraints + constraintsWithoutKeyboard + constraintsWithKeyboard
        NSLayoutConstraint.deactivate(allConstraints)
        NSLayoutConstraint.activate(finalConstraints)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
            self.shadowView.backgroundColor = .clear
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Setup view
    
    private func setup() {
        let hideKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabGesture))
        shadowView.addGestureRecognizer(hideKeyboardRecognizer)
        
        newMemberView.cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        newMemberView.confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        newMemberView.avatarImage.addTarget(self, action: #selector(setImage), for: .touchUpInside)
    }
    
    // MARK: - Fill view
    
    private func fill() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(newMemberView)
        
        startedConstraints = [
            newMemberView.topAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        finalConstraints = [
            newMemberView.bottomAnchor.constraint(equalTo: topAnchor)
        ]
        
        constraintsWithKeyboard = [
            newMemberView.topAnchor.constraint(equalTo: topAnchor, constant: 150)
        ]
        
        constraintsWithoutKeyboard = [
            newMemberView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(startedConstraints)
        
        NSLayoutConstraint.activate([
            newMemberView.centerXAnchor.constraint(equalTo: centerXAnchor),
            newMemberView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            newMemberView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.32)
        ])
        
    }
    
    // MARK: - Selectors
    
    @objc func tabGesture() {
        if isKeyboardShown {
            endEditing(true)
        } else {
            removeWithAnimation()
        }
    }
    
    @objc func cancel() {
        isFinished = true
        endEditing(true)
        removeWithAnimation()
    }
    
    @objc func confirm() {
        isFinished = true
        endEditing(true)
        removeWithAnimation()
        
        guard let firstName = newMemberView.firstAndLastNames.firstTextField.text,
              let lastName = newMemberView.firstAndLastNames.secondTextField.text else {return}
        
        var description = newMemberView.extraInfoTextField.text
        
        var image: UIImage? = nil
        
        if newMemberView.avatarImage.imageView?.image != UIImage(named: "setImage") {
            image = newMemberView.avatarImage.imageView?.image
        }
        
        if description == "Дополнительная информация" {description = nil}
        
        delegate?.addMember(firstName: firstName, lastName: lastName, description: description, image: image)
    }
    
    @objc func setImage() {
        delegate?.setImage() 
    }
}
