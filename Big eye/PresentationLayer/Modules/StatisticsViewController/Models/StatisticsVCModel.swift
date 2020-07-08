//
//  StatisticsVCModel.swift
//  Big eye
//
//  Created by Const. on 07.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct StatModel {
    let name: String
    let visitsAndPasses: VisitsAndPasses
    var percentOfVisits: Double = 0
}

struct VisitsAndPasses {
    var visits: Double
    var passes: Double
}

protocol IStatisticsVCModel {
    func fetchStatistics() -> [StatisticsModel]
    func countOfVisitsAndPasses(model: [StatisticsModel]) -> VisitsAndPasses
    func bestSubjectVisitsAndPasses(model: [StatisticsModel]) -> StatModel
    func badSubjectVisitsAndPasses(model: [StatisticsModel]) -> StatModel
    func bestStudentVisitsAndPasses(model: [StatisticsModel]) -> StatModel
    func badStudentVisitsAndPasses(model: [StatisticsModel]) -> StatModel
}

class StatisticsVCModel: IStatisticsVCModel {
    private let statisticsService: IStatisticsService
    
    init(service: IStatisticsService) {
        self.statisticsService = service
    }
    
    func fetchStatistics() -> [StatisticsModel] {
        return statisticsService.fetchStatistics()
    }
    
    func countOfVisitsAndPasses(model: [StatisticsModel]) -> VisitsAndPasses {
        var visitsAndPasses = VisitsAndPasses(visits: 0, passes: 0)
        
        for cell in model {
            for mark in cell.marks {
                if mark.isAttended {
                    visitsAndPasses.visits += 1
                } else {
                    visitsAndPasses.passes += 1
                }
            }
        }
        return visitsAndPasses
    }
    
    
    func bestSubjectVisitsAndPasses(model: [StatisticsModel]) -> StatModel {
        
        var subjects = [String:VisitsAndPasses]()
        
        for cell in model {
            if subjects[cell.subject] == nil {
                subjects[cell.subject] = VisitsAndPasses(visits: 0, passes: 0)
            }
            
            for mark in cell.marks {
                if mark.isAttended {
                    subjects[cell.subject]?.visits += 1
                } else {
                    subjects[cell.subject]?.passes += 1
                }
            }
        }
        
        var bestSubject = StatModel(name: "", visitsAndPasses: VisitsAndPasses(visits: 0, passes: 0))
        
        for (key, value) in subjects {
            let persent = (100 * value.visits) / (value.visits + value.passes)
            if persent > bestSubject.percentOfVisits {
                let newBestSubject = StatModel(name: key, visitsAndPasses: value, percentOfVisits: persent)
                bestSubject = newBestSubject
            }
        }
        
        return bestSubject
        
    }
    
    
    
    func badSubjectVisitsAndPasses(model: [StatisticsModel]) -> StatModel {
        var subjects = [String:VisitsAndPasses]()
        
        for cell in model {
            if subjects[cell.subject] == nil {
                subjects[cell.subject] = VisitsAndPasses(visits: 0, passes: 0)
            }
            
            for mark in cell.marks {
                if mark.isAttended {
                    subjects[cell.subject]?.visits += 1
                } else {
                    subjects[cell.subject]?.passes += 1
                }
            }
        }
        
        var badSubject = StatModel(name: "", visitsAndPasses: VisitsAndPasses(visits: 0, passes: 0), percentOfVisits: 100)
        
        for (key, value) in subjects {
            let persent = (100 * value.visits) / (value.visits + value.passes)
            if persent < badSubject.percentOfVisits {
                let newBadSubject = StatModel(name: key, visitsAndPasses: value, percentOfVisits: persent)
                badSubject = newBadSubject
            }
        }
        
        return badSubject
    }
    
    func bestStudentVisitsAndPasses(model: [StatisticsModel]) -> StatModel {
        var students = [String:VisitsAndPasses]()
        
        for cell in model {
            
            for mark in cell.marks {
                let studentName = mark.person.lastName + " " + mark.person.firstName
                if students[studentName] == nil {
                    students[studentName] = VisitsAndPasses(visits: 0, passes: 0)
                }
                
                if mark.isAttended {
                    students[studentName]?.visits += 1
                } else {
                    students[studentName]?.passes += 1
                }
            }
        }
        
        var bestStudent = StatModel(name: "", visitsAndPasses: VisitsAndPasses(visits: 0, passes: 0), percentOfVisits: 0)
        
        for (key, value) in students {
            let persent = (100 * value.visits) / (value.visits + value.passes)
            if persent > bestStudent.percentOfVisits {
                let newBestStudent = StatModel(name: key, visitsAndPasses: value, percentOfVisits: persent)
                bestStudent = newBestStudent
            }
        }
        
        return bestStudent
    }
    
    func badStudentVisitsAndPasses(model: [StatisticsModel]) -> StatModel {
        var students = [String:VisitsAndPasses]()
        
        for cell in model {
            
            for mark in cell.marks {
                let studentName = mark.person.lastName + " " + mark.person.firstName
                if students[studentName] == nil {
                    students[studentName] = VisitsAndPasses(visits: 0, passes: 0)
                }
                
                if mark.isAttended {
                    students[studentName]?.visits += 1
                } else {
                    students[studentName]?.passes += 1
                }
            }
        }
        
        var badStudent = StatModel(name: "", visitsAndPasses: VisitsAndPasses(visits: 0, passes: 0), percentOfVisits: 100)
        
        for (key, value) in students {
            let persent = (100 * value.visits) / (value.visits + value.passes)
            if persent < badStudent.percentOfVisits {
                let newBadStudent = StatModel(name: key, visitsAndPasses: value, percentOfVisits: persent)
                badStudent = newBadStudent
            }
        }
        
        return badStudent
    }
}
