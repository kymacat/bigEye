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
        
        
        // test data
        data.append(TimetableModel(name: "Понедельник", subjects: [
        TimetableRow(startTime: "11:40", endTime: "13:10", teacher: "Кудрявцева Ирина Владимировна", subjectNeme: "Математическая статистика"),
        TimetableRow(startTime: "13:30", endTime: "15:00", teacher: "Кудрявцева Ирина Владимировна", subjectNeme: "Математическая статистика"),
        TimetableRow(startTime: "15:20", endTime: "16:50", teacher: "Поляков Николай Алексеевич", subjectNeme: "Электротехника и электроника")
        ]))

        data.append(TimetableModel(name: "Вторник", subjects: [
        TimetableRow(startTime: "08:20", endTime: "09:50", teacher: "Егоров Михаил Юрьевич", subjectNeme: "Дополнительные главы физики"),
        TimetableRow(startTime: "10:00", endTime: "11:30", teacher: "Стафеев Сергей Константинович", subjectNeme: "Дополнительные главы физики"),
        TimetableRow(startTime: "11:40", endTime: "13:10", teacher: "Анохина Инна Владимировна", subjectNeme: "Иностранный язык"),
        TimetableRow(startTime: "13:30", endTime: "15:00", teacher: "Адольф Гитлер", subjectNeme: "Второй иностранный язык\n(немецкий)"),
        ]))

        data.append(TimetableModel(name: "Среда", subjects: [
        TimetableRow(startTime: "10:00", endTime: "11:30", teacher: "Приискалов Роман Андреевич", subjectNeme: "Инструментальные средства разработки ПО"),
        TimetableRow(startTime: "11:40", endTime: "13:10", teacher: "Поляков Николай Алексеевич", subjectNeme: "Электротехника и электроника")
        ]))

        data.append(TimetableModel(name: "Четверг", subjects: [
        TimetableRow(startTime: "10:00", endTime: "11:30", teacher: "Береснев Артем Дмитриевич", subjectNeme: "Администрирование в ОС Windows Server"),
        TimetableRow(startTime: "11:40", endTime: "13:10", teacher: "Рябчиков Игорь Александрович", subjectNeme: "Технологии программирования"),
        TimetableRow(startTime: "13:30", endTime: "15:00", teacher: "Рябчиков Игорь Александрович", subjectNeme: "Технологии программирования")
        ]))

        data.append(TimetableModel(name: "Пятница", subjects: [
        TimetableRow(startTime: "10:00", endTime: "11:30", teacher: "Адольф Гитлер", subjectNeme: "Второй иностранный язык (немецкий)"),
        TimetableRow(startTime: "11:40", endTime: "13:10", teacher: "Анохина Инна Владимировна", subjectNeme: "Иностранный язык"),
        TimetableRow(startTime: "13:30", endTime: "15:00", teacher: "Собенников Виктор Леонидович", subjectNeme: "Технологии программирования")
        ]))
        
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
    
    
    //test data
    var data: [TimetableModel] = []
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
    }
    
}

// MARK: - AddTimetableRowDelegate

extension TimetableViewController: AddTimetableRowDelegate {
    
    func addNewRow(newRow: TimetableRow) {
        timetableView.addTimetableView.data.append(newRow)
        timetableView.addTimetableView.updateAnimation()
    }
    
}
