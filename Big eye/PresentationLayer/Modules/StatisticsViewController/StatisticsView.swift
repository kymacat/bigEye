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
    
    let chartView = PieChartView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fill()
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fill()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .white
        chartView.legend.enabled = false
        chartView.usePercentValuesEnabled = true
        chartView.holeRadiusPercent = 0.3
        chartView.transparentCircleRadiusPercent = 0.4
        chartView.chartDescription?.text = ""
    }
    
    // MARK: - Fill
    
    private func fill() {
        
        addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            chartView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartView.widthAnchor.constraint(equalToConstant: 300),
            chartView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    
}
