//
//  TimetableViewController.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class TimetableViewController: UIViewController {
    
    //Dependencies
    private let presentationAssembly: IPresentationAssembly
    private let model: ITimetableVCModel
    
    //view
    private let timetableView = TimetableView()
    private let cellRowHeight: CGFloat = 75
    
    private var data: [TimetableModel] = []
    
    // MARK: - Init
    
    init(model: ITimetableVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.presentationAssembly = assembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = timetableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timetableView.tableView.delegate = self
        timetableView.tableView.dataSource = self
        
        timetableView.addTimetableView.delegate = self
        
        timetableView.tableView.register(TimetableCell.self, forCellReuseIdentifier: "TimetableCell")
        timetableView.tableView.register(AddTimetableCell.self, forCellReuseIdentifier: "AddTimetableCell")
        
        data = model.fetchCells()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    // MARK: - Keyboard show/hide
    
    @objc func keyboardWasShown() {
        timetableView.setConstraintsWithKeyboard()
    }
    
    @objc func keyboardWillBeHidden() {
        timetableView.setConstraintsWithoutKeyboard()
    }
    
}


// MARK: - TableView DataSource

extension TimetableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == data.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddTimetableCell", for: indexPath) as? AddTimetableCell else {return UITableViewCell()}
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableCell", for: indexPath) as? TimetableCell else {return UITableViewCell()}
        
        cell.configure(model: data[indexPath.row], rowHeight: cellRowHeight)
        
        return cell
    }
    
}

// MARK: - TableView Delegate

extension TimetableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == data.count {
            return 60
        }
        
        return CGFloat(data[indexPath.row].subjects.count) * cellRowHeight + 20 + cellRowHeight/2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddTimetableCell else {
            return
        }
        
        cell.didSelect()
        timetableView.showAddTimetableView()
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddTimetableCell else {
            return
        }
        
        cell.didHighlight()
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AddTimetableCell else {
            return
        }
        
        cell.didUnhighlight()
    }
}

// MARK: - AddTimetableViewDelegate

extension TimetableViewController: AddTimetableViewDelegate {
    
    func fillNewRow() {
        let controller = presentationAssembly.addTimetableRowViewController()
        controller.delegate = self
        self.present(controller, animated: true)
    }
    
    func addToTimetable(newItem: TimetableModel) {
        data.append(newItem)
        timetableView.tableView.reloadData()
        model.saveCell(cell: newItem)
    }
    
}

// MARK: - AddTimetableRowDelegate

extension TimetableViewController: AddTimetableRowDelegate {
    
    func addNewRow(newRow: TimetableRowModel) {
        timetableView.addTimetableView.data.append(newRow)
        timetableView.addTimetableView.updateAnimation()
    }
    
}
