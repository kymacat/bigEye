//
//  StatisticsView.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit
import Charts

class StatisticsView: UIView {
    
    var isPersonallyStatistics: Bool
    
    let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let mainChartView = PieChartView()
    
    
    let mainAttendanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        label.textAlignment = .center
        label.text = "Общая посещаемость"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let bestJubjectChartView = PieChartView()
    
    let bestSubjectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        label.textAlignment = .center
        label.text = "Самый посещаемый предмет"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let badJubjectChartView = PieChartView()
    
    let badSubjectLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        label.textAlignment = .center
        label.text = "Наименее посещаемый предмет"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bestStudentChartView = PieChartView()
    
    let bestStudentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        label.textAlignment = .center
        label.text = "Студент с наибольшей посещаемостью"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let badStudentChartView = PieChartView()
    
    let badStudentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 20)
        label.textColor = UIColor(red: 29/255, green: 69/255, blue: 130/255, alpha: 1)
        label.textAlignment = .center
        label.text = "Студент с наименьшей посещаемостью"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    init(isPersonallyStatistics: Bool) {
        self.isPersonallyStatistics = isPersonallyStatistics
        super.init(frame: CGRect())
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        setupChart(chart: mainChartView)
        setupChart(chart: bestJubjectChartView)
        setupChart(chart: badJubjectChartView)
        setupChart(chart: bestStudentChartView)
        setupChart(chart: badStudentChartView)
    }
    
    private func setupChart(chart: PieChartView) {
        chart.legend.enabled = false
        chart.usePercentValuesEnabled = true
        chart.holeRadiusPercent = 0.3
        chart.transparentCircleRadiusPercent = 0.4
        chart.chartDescription?.text = ""
        chart.entryLabelColor = .black
        chart.setExtraOffsets(left: 20, top: 0, right: 20, bottom: 0)
    }
    
    // MARK: - Fill
    
    private func fill() {
        
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // MARK: - main chart
        
        scrollView.addSubview(mainAttendanceLabel)
        
        NSLayoutConstraint.activate([
            mainAttendanceLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            mainAttendanceLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            mainAttendanceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            mainAttendanceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
        ])
        
        scrollView.addSubview(mainChartView)
        mainChartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainChartView.topAnchor.constraint(equalTo: mainAttendanceLabel.bottomAnchor, constant: -20),
            mainChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            mainChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainChartView.heightAnchor.constraint(equalTo: mainChartView.widthAnchor)
        ])
        
        // MARK: - Best subject chart
        
        scrollView.addSubview(bestSubjectLabel)
        
        NSLayoutConstraint.activate([
            bestSubjectLabel.topAnchor.constraint(equalTo: mainChartView.bottomAnchor),
            bestSubjectLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            bestSubjectLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            bestSubjectLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
        ])
        
        bestJubjectChartView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(bestJubjectChartView)
        
        NSLayoutConstraint.activate([
            bestJubjectChartView.topAnchor.constraint(equalTo: bestSubjectLabel.bottomAnchor, constant: -20),
            bestJubjectChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bestJubjectChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bestJubjectChartView.heightAnchor.constraint(equalTo: bestJubjectChartView.widthAnchor)
        ])
        
        // MARK: - Bad subject chart
        
        scrollView.addSubview(badSubjectLabel)
        
        NSLayoutConstraint.activate([
            badSubjectLabel.topAnchor.constraint(equalTo: bestJubjectChartView.bottomAnchor),
            badSubjectLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            badSubjectLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            badSubjectLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
        ])
        
        badJubjectChartView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(badJubjectChartView)
        
        NSLayoutConstraint.activate([
            badJubjectChartView.topAnchor.constraint(equalTo: badSubjectLabel.bottomAnchor, constant: -20),
            badJubjectChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            badJubjectChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            badJubjectChartView.heightAnchor.constraint(equalTo: bestJubjectChartView.widthAnchor)
        ])
        
        if isPersonallyStatistics {
            badJubjectChartView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
            return
        }
        
        // MARK: - Best student chart
        
        scrollView.addSubview(bestStudentLabel)
        
        NSLayoutConstraint.activate([
            bestStudentLabel.topAnchor.constraint(equalTo: badJubjectChartView.bottomAnchor),
            bestStudentLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            bestStudentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            bestStudentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
        ])
        
        bestStudentChartView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(bestStudentChartView)
        
        NSLayoutConstraint.activate([
            bestStudentChartView.topAnchor.constraint(equalTo: bestStudentLabel.bottomAnchor, constant: -20),
            bestStudentChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            bestStudentChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            bestStudentChartView.heightAnchor.constraint(equalTo: bestStudentChartView.widthAnchor)
        ])
        
        // MARK: - Bad student chart
        
        scrollView.addSubview(badStudentLabel)
        
        NSLayoutConstraint.activate([
            badStudentLabel.topAnchor.constraint(equalTo: bestStudentChartView.bottomAnchor),
            badStudentLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20),
            badStudentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            badStudentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10)
        ])
        
        badStudentChartView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(badStudentChartView)
        
        NSLayoutConstraint.activate([
            badStudentChartView.topAnchor.constraint(equalTo: badStudentLabel.bottomAnchor, constant: -20),
            badStudentChartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            badStudentChartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            badStudentChartView.heightAnchor.constraint(equalTo: badStudentChartView.widthAnchor),
            badStudentChartView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        ])
        
    }

    
}
