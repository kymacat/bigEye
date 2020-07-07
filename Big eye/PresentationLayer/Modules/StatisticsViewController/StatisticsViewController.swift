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
    
    var visitDataEntry = PieChartDataEntry(value: 0)
    var passDataEntry = PieChartDataEntry(value: 0)
    
    var dataEntries = [PieChartDataEntry]()
    
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
        
        visitDataEntry.label = "Посещения"
        passDataEntry.label = "Пропуски"
        
        dataEntries = [visitDataEntry, passDataEntry]
        
        getCurrData()
        
    }
    
    func getCurrData() {
        data = model.fetchStatistics()
        
        guard data.count != 0 else {
            setEmptyChart()
            return
        }
        
        let visitsAndPasses = model.countOfVisitsAndPasses(model: data)
        visitDataEntry.value = visitsAndPasses.0
        passDataEntry.value = visitsAndPasses.1
        updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        let object = PieChartData(dataSet: chartDataSet)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        object.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        object.setValueFont(.systemFont(ofSize: 11, weight: .light))
        object.setValueTextColor(.black)
        
        let colors = [UIColor.systemGreen, UIColor.systemRed]
        
        chartDataSet.colors = colors 
        
        statView.chartView.data = object
        
        statView.chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setEmptyChart() {
        visitDataEntry.value = 1
        let chartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        let object = PieChartData(dataSet: chartDataSet)
        object.setValueTextColor(.gray)
        
        let colors = [UIColor.gray]
        
        chartDataSet.colors = colors
        
        statView.chartView.data = object
        
        statView.chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
}
