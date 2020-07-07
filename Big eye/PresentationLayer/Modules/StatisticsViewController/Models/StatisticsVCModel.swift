//
//  StatisticsVCModel.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol IStatisticsVCModel {
    func fetchStatistics() -> [StatisticsModel]
    func countOfVisitsAndPasses(model: [StatisticsModel]) -> (Double, Double)
}

class StatisticsVCModel: IStatisticsVCModel {
    private let statisticsService: IStatisticsService
    
    init(service: IStatisticsService) {
        self.statisticsService = service
    }
    
    func fetchStatistics() -> [StatisticsModel] {
        return statisticsService.fetchStatistics()
    }
    
    func countOfVisitsAndPasses(model: [StatisticsModel]) -> (Double, Double) {
        var visits: Double = 0
        var passes: Double = 0
        
        for cell in model {
            for mark in cell.marks {
                if mark.isAttended {
                    visits += 1
                } else {
                    passes += 1
                }
            }
        }
        return (visits, passes)
    }
}
