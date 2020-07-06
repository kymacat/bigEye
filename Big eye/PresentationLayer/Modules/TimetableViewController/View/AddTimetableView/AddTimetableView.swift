//
//  AddTimetableView.swift
//  Big eye
//
//  Created by Const. on 05.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol AddTimetableViewDelegate {
    func addNewRow()
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
        
        newTimetableView.tableView.delegate = self
        newTimetableView.tableView.dataSource = self
        
        newTimetableView.tableView.register(TimetableRowCell.self, forCellReuseIdentifier: "timetableRowCell")
        newTimetableView.tableView.register(AddTimetableRowCell.self, forCellReuseIdentifier: "addTimetableRowCell")
        
        newTimetableView.cancelButton.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        newTimetableView.confirmButton.addTarget(self, action: #selector(confirmButton), for: .touchUpInside)
    }
    
    // MARK: - Animations
    
    @objc func cancelButton() {
        removeWithAnimation()
    }
    
    @objc func confirmButton() {
        
    }
    
    private var startedConstraints = [NSLayoutConstraint]()
    private var fixedConstraints = [NSLayoutConstraint]()
    private var finalConstraints = [NSLayoutConstraint]()
    
    func showAnimation() {
        NSLayoutConstraint.deactivate(startedConstraints)
        NSLayoutConstraint.activate(fixedConstraints)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
            self.shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        })
    }
    
    func removeWithAnimation() {
        let allConstraints = startedConstraints + fixedConstraints
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
        
        fixedConstraints = [
            newTimetableView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        finalConstraints = [
            newTimetableView.bottomAnchor.constraint(equalTo: topAnchor)
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
        let rowHeight: CGFloat = 75
        let buttonsHeight: CGFloat = 45
        heightConstraint = newTimetableView.heightAnchor.constraint(equalToConstant: rowHeight * CGFloat(data.count + 1) + buttonsHeight)
        heightConstraint.isActive = true
    }
}

// MARK: - TableView DataSource

extension AddTimetableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count == 0 {
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
        delegate?.addNewRow()
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
