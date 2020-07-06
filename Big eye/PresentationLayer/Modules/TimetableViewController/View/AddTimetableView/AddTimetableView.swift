//
//  AddTimetableView.swift
//  Big eye
//
//  Created by Const. on 05.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol AddTimetableViewDelegate {
    func fillNewRow()
    func addToTimetable(newItem: TimetableModel)
}

class AddTimetableView: UIView {
    
    var delegate: AddTimetableViewDelegate?
    
    let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newTimetableView = NewTimetableView()
    
    var data = [TimetableRow]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        fill()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        fill()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let hideKeyboardRecognizer = UITapGestureRecognizer(target: self, action: #selector(tabGesture))
        shadowView.addGestureRecognizer(hideKeyboardRecognizer)
        
        newTimetableView.tableView.delegate = self
        newTimetableView.tableView.dataSource = self
        
        newTimetableView.headerTextField.delegate = self
        
        newTimetableView.tableView.register(TimetableRowCell.self, forCellReuseIdentifier: "timetableRowCell")
        newTimetableView.tableView.register(AddTimetableRowCell.self, forCellReuseIdentifier: "addTimetableRowCell")
        
        newTimetableView.cancelButton.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        newTimetableView.confirmButton.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
    }
    
    @objc func tabGesture() {
        endEditing(true)
    }
    
    // MARK: - Animations
    
    @objc func cancelButton() {
        isFinished = true
        removeWithAnimation()
    }
    
    @objc func confirmButton() {
        guard let name = newTimetableView.headerTextField.text,
            data.count != 0 else {
            return
        }
        
        isFinished = true
        let newItem = TimetableModel(name: name, subjects: data)
        removeWithAnimation()
        delegate?.addToTimetable(newItem: newItem)
    }
    
    private var startedConstraints = [NSLayoutConstraint]()
    private var finalConstraints = [NSLayoutConstraint]()
    private var constraintsWithoutKeyboard = [NSLayoutConstraint]()
    private var constraintsWithKeyboard = [NSLayoutConstraint]()
    
    var isFinished = false
    
    func setConstraintsWithoutKeyboard() {
        if isFinished {return}
        
        NSLayoutConstraint.deactivate(constraintsWithKeyboard)
        NSLayoutConstraint.activate(constraintsWithoutKeyboard)
        
        UIView.animate(withDuration: 2, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func setConstraintsWithKeyboard() {
        NSLayoutConstraint.deactivate(constraintsWithoutKeyboard)
        NSLayoutConstraint.activate(constraintsWithKeyboard)
        
        UIView.animate(withDuration: 2, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func showAnimation() {
        NSLayoutConstraint.deactivate(startedConstraints)
        NSLayoutConstraint.activate(constraintsWithoutKeyboard)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
            self.shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
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
    
    func updateAnimation() {
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutSubviews()
            self.layoutIfNeeded()
        })
        newTimetableView.tableView.reloadData()
    }
    
    // MARK: - Fill
    
    private func fill() {
        addSubview(shadowView)
        
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        addSubview(newTimetableView)
        
        startedConstraints = [
            newTimetableView.topAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        finalConstraints = [
            newTimetableView.bottomAnchor.constraint(equalTo: topAnchor)
        ]
        
        constraintsWithKeyboard = [
            newTimetableView.topAnchor.constraint(equalTo: topAnchor, constant: 150)
        ]
        
        constraintsWithoutKeyboard = [
            newTimetableView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate([
            newTimetableView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            newTimetableView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate(startedConstraints)
        
    }
    
    private var heightConstraint = NSLayoutConstraint()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setHeightConstraint()
    }
    
    private func setHeightConstraint() {
        guard data.count < 6 else {
            return
        }
        
        heightConstraint.isActive = false
        let headerHeight: CGFloat = 30
        let rowHeight: CGFloat = 75
        let buttonsHeight: CGFloat = 45
        heightConstraint = newTimetableView.heightAnchor.constraint(equalToConstant: rowHeight * CGFloat(data.count + 1) + buttonsHeight + headerHeight)
        heightConstraint.isActive = true
    }
}

// MARK: - TableView DataSource

extension AddTimetableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count == 0 || newTimetableView.headerTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            newTimetableView.confirmButton.isEnabled = false
        } else {
            newTimetableView.confirmButton.isEnabled = true
        }
        return data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == data.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addTimetableRowCell", for: indexPath) as? AddTimetableRowCell else {return UITableViewCell()}
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "timetableRowCell", for: indexPath) as? TimetableRowCell else {return UITableViewCell()}
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    
}

// MARK: - TableView Delegate

extension AddTimetableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddTimetableRowCell else {
            return
        }
        
        cell.didSelect()
        delegate?.fillNewRow()
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddTimetableRowCell else {
            return
        }
        
        cell.didHighlight()
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddTimetableRowCell else {
            return
        }
        
        cell.didUnhighlight()
    }
}

// MARK: - TextFieldDelegate

extension AddTimetableView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if data.count == 0 || newTimetableView.headerTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            newTimetableView.confirmButton.isEnabled = false
        } else {
            newTimetableView.confirmButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
}
