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
        
        timetableView.tableView.register(TimetableCell.self, forCellReuseIdentifier: "TimetableCell")
        
        
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
        TimetableRow(startTime: "13:30", endTime: "15:00", teacher: "Адольф Гитлер", subjectNeme: "Второй иностранный язык (немецкий)"),
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
    
    
    //test data
    var data: [TimetableModel] = []
}


// MARK: - TableView DataSource

extension TimetableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableCell", for: indexPath) as? TimetableCell else {return UITableViewCell()}
        
        cell.configure(model: data[indexPath.row], rowHeight: cellRowHeight)
        
        return cell
    }
    
}

// MARK: - TableView Delegate

extension TimetableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(data[indexPath.row].subjects.count) * cellRowHeight + 20 + cellRowHeight/2
    }
}
