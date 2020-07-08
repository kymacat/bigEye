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
    private let statView = StatisticsView()
    
    
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
    
    init(model: IStatisticsVCModel, assembly: IPresentationAssembly) {
        self.model = model
        self.presentationAssembly = assembly
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
            UIColor(red: 60/255, green: 232/255, blue: 198/255, alpha: 1),
            UIColor(red: 255/255, green: 133/255, blue: 133/255, alpha: 1)
        ])
        
        
        let bestSubjectVisitsAndPasses = model.bestSubjectVisitsAndPasses(model: data)
        statView.bestSubjectLabel.text = "Cамый посещаемый предмет\n" + bestSubjectVisitsAndPasses.name
        bestSubjectVisitsDataEntry.value = bestSubjectVisitsAndPasses.visitsAndPasses.visits
        bestSubjectPassesDataEntry.value = bestSubjectVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.bestJubjectChartView, entries: bestSubjectDataEntries, colors: [
            UIColor(red: 140/255, green: 255/255, blue: 140/255, alpha: 1),
            UIColor(red: 255/255, green: 148/255, blue: 81/255, alpha: 1)
        ])
        
        let badSubjectVisitsAndPasses = model.badSubjectVisitsAndPasses(model: data)
        statView.badSubjectLabel.text = "Наименее посещаемый предмет\n" + badSubjectVisitsAndPasses.name
        badSubjectVisitsDataEntry.value = badSubjectVisitsAndPasses.visitsAndPasses.visits
        badSubjectPassesDataEntry.value = badSubjectVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.badJubjectChartView, entries: badSubjectDataEntries, colors: [
            UIColor(red: 73/255, green: 255/255, blue: 120/255, alpha: 1),
            UIColor(red: 255/255, green: 55/255, blue: 111/255, alpha: 1)
        ])
        
        let bestStudentVisitsAndPasses = model.bestStudentVisitsAndPasses(model: data)
        statView.bestStudentLabel.text = "Студент с наибольшей посещаемостью\n" + bestStudentVisitsAndPasses.name
        bestStudentVisitsDataEntry.value = bestStudentVisitsAndPasses.visitsAndPasses.visits
        bestStudentPassesDataEntry.value = bestStudentVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.bestStudentChartView, entries: bestStudentDataEntries, colors: [
            UIColor(red: 23/255, green: 255/255, blue: 247/255, alpha: 1),
            UIColor(red: 255/255, green: 61/255, blue: 147/255, alpha: 1)
        ])
        
        let badStudentVisitsAndPasses = model.badStudentVisitsAndPasses(model: data)
        statView.badStudentLabel.text = "Студент с наименьшей посещаемостью\n" + badStudentVisitsAndPasses.name
        badStudentVisitsDataEntry.value = badStudentVisitsAndPasses.visitsAndPasses.visits
        badStudentPassesDataEntry.value = badStudentVisitsAndPasses.visitsAndPasses.passes
        updateChartData(chart: statView.badStudentChartView, entries: badStudentDataEntries, colors: [
            UIColor(red: 172/255, green: 221/255, blue: 176/255, alpha: 1),
            UIColor(red: 255/255, green: 172/255, blue: 176/255, alpha: 1)
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
