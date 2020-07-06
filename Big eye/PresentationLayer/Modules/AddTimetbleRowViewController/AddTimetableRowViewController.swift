//
//  AddTimetableRowViewController.swift
//  Big eye
//
//  Created by Const. on 06.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit

protocol AddTimetableRowDelegate {
    func addNewRow(newRow: TimetableRow)
}

class AddTimetableRowViewController: UIViewController {
    
    var delegate: AddTimetableRowDelegate?
    
    let addView = AddTimetableRowView()
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = addView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView.timePickerView.dataSource = self
        addView.timePickerView.delegate = self
        
        addView.cancelButton.addTarget(self, action: #selector(cancelButton), for: .touchUpInside)
        addView.saveButton.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        
        
    }
    
    // MARK: - Actions
    
    @objc func cancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButton() {
        guard let subject = addView.doubleTextField.firstTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let teacher = addView.doubleTextField.secondTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        guard subject != "" && teacher != "" else {
            showErrorAlert(with: "Введите название предмета и ФИО преподавателя")
            return
        }
        
        let startedHour = hours[addView.timePickerView.selectedRow(inComponent: 0)]
        let startedMinute = minutes[addView.timePickerView.selectedRow(inComponent: 1)]
        
        let endedHour = hours[addView.timePickerView.selectedRow(inComponent: 2)]
        let endedMinute = minutes[addView.timePickerView.selectedRow(inComponent: 3)]
        
        guard startedHour <= endedHour else {
            showErrorAlert(with: "Время начала не может быть больше, чем время окончания")
            return
        }
        
        if startedHour == endedHour && startedMinute >= endedMinute {
            showErrorAlert(with: "Время начала не может быть больше, чем время окончания")
            return
        }
        
        let startedHourForRow = generateReadableTime(time: startedHour)
        let startedMinuteForRow = generateReadableTime(time: startedMinute)
        let endedHourForRow = generateReadableTime(time: endedHour)
        let endedMinuteForRow = generateReadableTime(time: endedMinute)
        
        let timetableRow = TimetableRow(startTime: "\(startedHourForRow):\(startedMinuteForRow)", endTime: "\(endedHourForRow):\(endedMinuteForRow)", teacher: teacher, subjectNeme: subject)
        
        dismiss(animated: true, completion: {
            self.delegate?.addNewRow(newRow: timetableRow)
        })
    }
    
    private func generateReadableTime(time: Int) -> String {
        var readableTime = String(time)
        if time < 10 {
            readableTime = "0" + String(time)
        }
        return readableTime
    }
    
    private func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    let hours = Array(0...23)
    let minutes = Array(0...59)

}

// MARK: - PickerView DataSource

extension AddTimetableRowViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component % 2 == 0 {
            return hours.count
        } else {
            return minutes.count
        }
    }
    
    
}

// MARK: - PickerView Delegate

extension AddTimetableRowViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component % 2 == 0 {
            return String(hours[row])
        } else {
            if minutes[row] < 10 {
                return "0" + String(minutes[row])
            }
            return String(minutes[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let startHour = hours[pickerView.selectedRow(inComponent: 0)]
        let startMinute = minutes[pickerView.selectedRow(inComponent: 1)]
        var currStartMinute = String(startMinute)
        if startMinute < 10 {
            currStartMinute = "0" + String(startMinute)
        }
        
        let endHour = hours[pickerView.selectedRow(inComponent: 2)]
        let endMinute = minutes[pickerView.selectedRow(inComponent: 3)]
        var currEndMinute = String(endMinute)
        if endMinute < 10 {
            currEndMinute = "0" + String(endMinute)
        }
        
        addView.startTimeLabel.text = "Время начала - \(startHour):\(currStartMinute)"
        addView.endTimeLabel.text = "Время окончания - \(endHour):\(currEndMinute)"
    }
    
}
