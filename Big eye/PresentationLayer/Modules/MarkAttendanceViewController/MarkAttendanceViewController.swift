//
//  MarkAttendanceViewController.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

class MarkAttendanceViewController: UIViewController {
    
    let attendanceView: MarkAttendanceVCView
    private let model: IMarkAttendanceVCModel
    
    var data = [AttendanceModel]()
    
    // MARK: - Init
    
    init(model:IMarkAttendanceVCModel, teacher: String, subject: String) {
        self.model = model
        attendanceView = MarkAttendanceVCView(teacher: teacher, subject: subject)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = attendanceView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        attendanceView.tableView.dataSource = self
        
        attendanceView.tableView.register(MarkAttendanceCell.self, forCellReuseIdentifier: "MarkAttendanceCell")
        
        data = model.fetchData()
        
        attendanceView.saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        attendanceView.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    @objc func saveAction() {
        guard data.count > 0 else { return }
        let date = attendanceView.datePicker.date
        model.saveStatistics(date: date, teacher: attendanceView.teacher, subject: attendanceView.subject, stat: data)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - TableView DataSource

extension MarkAttendanceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MarkAttendanceCell", for: indexPath) as? MarkAttendanceCell else {return UITableViewCell()}
        
        cell.configure(with: data[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    
}

// MARK: - MarkAttendanceCellDelegate

extension MarkAttendanceViewController: MarkAttendanceCellDelegate {
    
    func changeStatus(firstName: String, lastname: String, with status: Bool) {
        
        for (index, person) in data.enumerated() {
            if person.person.firstName == firstName && person.person.lastName == lastname {
                data[index].isAttended = status
                return
            }
        }
        
    }
}


