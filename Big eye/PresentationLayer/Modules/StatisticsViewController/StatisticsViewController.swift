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
    
    var iosDataEntry = PieChartDataEntry(value: 50)
    var macDataEntry = PieChartDataEntry(value: 30)
    
    var numberOfDounloadsDataEntries = [PieChartDataEntry]()
    
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
        
        statView.chartView.chartDescription?.text = ""
        
        iosDataEntry.label = "iOS"
        macDataEntry.label = "macOS"
        
        numberOfDounloadsDataEntries = [iosDataEntry, macDataEntry]
        
        updateChartData()
        
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfDounloadsDataEntries, label: nil)
        let object = PieChartData(dataSet: chartDataSet)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = "%"
        object.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        object.setValueFont(.systemFont(ofSize: 11, weight: .light))
        object.setValueTextColor(.black)
        
        let colors = [UIColor.red, UIColor.green]
        
        chartDataSet.colors = colors 
        
        statView.chartView.data = object
        
        statView.chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
}
