//
//  StatisticsViewController.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    
    //Depencies
    private let model: IStatisticsVCModel
    private let presentationAssembly: IPresentationAssembly
    
    //view
    private let statView: StatisticsView
    var groupMember: GroupMemberModel?
    
    var data = [StatisticsModel]()
    
    // MARK: - Data for pie charts
    
    //data for main chart
    var totalVisitDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Посещения"
        return entry
    }()
    var totalsPassDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Пропуски"
        return entry
    }()

    var mainDataEntries = [PieChartDataEntry]()
    
    
    //data for bestSubject chart
    var bestSubjectVisitsDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Посещения"
        return entry
    }()

    var bestSubjectPassesDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Пропуски"
        return entry
    }()
    var bestSubjectDataEntries = [PieChartDataEntry]()
    
    //data for badSubject chart
    var badSubjectVisitsDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Посещения"
        return entry
    }()

    var badSubjectPassesDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Пропуски"
        return entry
    }()
    var badSubjectDataEntries = [PieChartDataEntry]()
    
    //data for bestStudent chart
    var bestStudentVisitsDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Посещения"
        return entry
    }()

    var bestStudentPassesDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Пропуски"
        return entry
    }()
    var bestStudentDataEntries = [PieChartDataEntry]()
    
    //data for badStudent chart
    var badStudentVisitsDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Посещения"
        return entry
    }()

    var badStudentPassesDataEntry: PieChartDataEntry = {
        let entry = PieChartDataEntry(value: 0)
        entry.label = "Пропуски"
        return entry
    }()
    var badStudentDataEntries = [PieChartDataEntry]()
    
    
    // MARK: - Init
    
    init(model: IStatisticsVCModel, assembly: IPresentationAssembly, isPersonallyStatistics: Bool) {
        self.model = model
        self.presentationAssembly = assembly
        statView = StatisticsView(isPersonallyStatistics: isPersonallyStatistics)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = statView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstName = groupMember?.firstName, let lastName = groupMember?.lastName {
            navigationItem.title = lastName + " " + firstName
        }
        
        mainDataEntries = [totalVisitDataEntry, totalsPassDataEntry]
        bestSubjectDataEntries = [bestSubjectVisitsDataEntry, bestSubjectPassesDataEntry]
        badSubjectDataEntries = [badSubjectVisitsDataEntry, badSubjectPassesDataEntry]
        bestStudentDataEntries = [bestStudentVisitsDataEntry, bestStudentPassesDataEntry]
        badStudentDataEntries = [badStudentVisitsDataEntry, badStudentPassesDataEntry]
        
        getCurrData()
        
    }
    
    // MARK: - Work with pie charts
    
    func getCurrData() {
        data = model.fetchStatistics()
        
        if let person = groupMember, statView.isPersonallyStatistics {
            data = model.getPersonallyStatistics(model: data, person: person)
        }
        
        guard data.count != 0 else {
            setEmptyChart(chart: statView.mainChartView, entries: mainDataEntries)
            setEmptyChart(chart: statView.bestJubjectChartView, entries: bestSubjectDataEntries)
            setEmptyChart(chart: statView.badJubjectChartView, entries: badSubjectDataEntries)
            setEmptyChart(chart: statView.bestStudentChartView, entries: bestStudentDataEntries)
            setEmptyChart(chart: statView.badStudentChartView, entries: badStudentDataEntries)
            return
        }
        
        let visitsAndPasses = model.countOfVisitsAndPasses(model: data)
        totalVisitDataEntry.value = visitsAndPasses.visits
        totalsPassDataEntry.value = visitsAndPasses.passes
        updateChartData(chart: statView.mainChartView, entries: mainDataEntries, colors: [
            UIColor(red: 59/255, green: 200/255, blue: 238/255, alpha: 1),
            UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        ])
        
        
        let bestSubjectVisitsAndPasses = model.bestSubjectVisitsAndPasses(model: data)
        statView.bestSubjectLabel.text = "Cамый посещаемый предмет\n" + bestSubjectVisitsAndPasses.name
        bestSubjectVisitsDataEntry.value = bestSubjectVisitsAndPasses.visitsAndPasses.visits
        bestSubjectPassesDataEntry.value = bestSubjectVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.bestJubjectChartView, entries: bestSubjectDataEntries, colors: [
            UIColor(red: 69/255, green: 215/255, blue: 216/255, alpha: 1),
            UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        ])
        
        let badSubjectVisitsAndPasses = model.badSubjectVisitsAndPasses(model: data)
        statView.badSubjectLabel.text = "Наименее посещаемый предмет\n" + badSubjectVisitsAndPasses.name
        badSubjectVisitsDataEntry.value = badSubjectVisitsAndPasses.visitsAndPasses.visits
        badSubjectPassesDataEntry.value = badSubjectVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.badJubjectChartView, entries: badSubjectDataEntries, colors: [
            UIColor(red: 42/255, green: 146/255, blue: 217/255, alpha: 1),
            UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        ])
        
        let bestStudentVisitsAndPasses = model.bestStudentVisitsAndPasses(model: data)
        statView.bestStudentLabel.text = "Студент с наибольшей посещаемостью\n" + bestStudentVisitsAndPasses.name
        bestStudentVisitsDataEntry.value = bestStudentVisitsAndPasses.visitsAndPasses.visits
        bestStudentPassesDataEntry.value = bestStudentVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.bestStudentChartView, entries: bestStudentDataEntries, colors: [
            UIColor(red: 175/255, green: 216/255, blue: 220/255, alpha: 1),
            UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        ])
        
        let badStudentVisitsAndPasses = model.badStudentVisitsAndPasses(model: data)
        statView.badStudentLabel.text = "Студент с наименьшей посещаемостью\n" + badStudentVisitsAndPasses.name
        badStudentVisitsDataEntry.value = badStudentVisitsAndPasses.visitsAndPasses.visits
        badStudentPassesDataEntry.value = badStudentVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.badStudentChartView, entries: badStudentDataEntries, colors: [
            UIColor(red: 21/255, green: 84/255, blue: 138/255, alpha: 1),
            UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1)
        ])
        
    }
    
    func updateChartData(chart: PieChartView, entries: [PieChartDataEntry], colors: [UIColor]) {
        let chartDataSet = PieChartDataSet(entries: entries, label: nil)
        let object = PieChartData(dataSet: chartDataSet)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        object.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        object.setValueFont(.systemFont(ofSize: 14, weight: .bold))
        object.setValueTextColor(.black)
        
        chartDataSet.colors = colors
        
        chart.data = object
        
        chart.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setEmptyChart(chart: PieChartView, entries: [PieChartDataEntry]) {
        entries.first?.value = 1
        let chartDataSet = PieChartDataSet(entries: entries, label: nil)
        let object = PieChartData(dataSet: chartDataSet)
        object.setValueTextColor(.gray)
        
        let colors = [UIColor.gray]
        
        chartDataSet.colors = colors
        
        chart.data = object
        
        chart.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
}

// MARK: - EyeTabBarDelegate

extension StatisticsViewController: EyeTabBarDelegate {
    
    func switchedToNewController(idOfNewController: Int) {
        if isViewLoaded && idOfNewController == 2 {
            getCurrData()
        }
    }
    
}
