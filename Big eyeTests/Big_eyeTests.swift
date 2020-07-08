//
//  Big_eyeTests.swift
//  Big eyeTests
//
//  Created by Const. on 08.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import XCTest
@testable import Big_eye

// MARK: - IStatisticsService Mock

class StatisticsServiceMock: IStatisticsService {
    
    func fetchStatistics() -> [StatisticsModel] {
        return [
            StatisticsModel(date: Date(), teacher: "", subject: "Математическая статистика", marks: [
                AttendanceModel(isAttended: true, person: GroupMemberModel(image: nil, firstName: "Влад", lastName: "Яндола", description: nil)),
                AttendanceModel(isAttended: false, person: GroupMemberModel(image: nil, firstName: "Петр", lastName: "Петров", description: nil)),
                AttendanceModel(isAttended: false, person: GroupMemberModel(image: nil, firstName: "Петр", lastName: "Петров", description: nil)),
                AttendanceModel(isAttended: true, person: GroupMemberModel(image: nil, firstName: "Влад", lastName: "Яндола", description: nil)),
            ]),
            StatisticsModel(date: Date(), teacher: "", subject: "Электротехника и электроника", marks: [
                AttendanceModel(isAttended: false, person: GroupMemberModel(image: nil, firstName: "Влад", lastName: "Яндола", description: nil)),
                AttendanceModel(isAttended: false, person: GroupMemberModel(image: nil, firstName: "Петр", lastName: "Петров", description: nil)),
                AttendanceModel(isAttended: false, person: GroupMemberModel(image: nil, firstName: "Петр", lastName: "Петров", description: nil)),
                AttendanceModel(isAttended: true, person: GroupMemberModel(image: nil, firstName: "Влад", lastName: "Яндола", description: nil)),
            ])
        ]
    }
    
}


class Big_eyeTests: XCTestCase {

    // MARK: - Lifecycle
    
    private var statisticsModel: IStatisticsVCModel!
    

    override func setUp() {
        statisticsModel = StatisticsVCModel(service: StatisticsServiceMock())
    }
    
    // MARK: - Tests

    func testGetPersonallyStatistics() throws {
        
        //Given
        let expectedResult = "Петр Петров"
        let startedData = statisticsModel.fetchStatistics()
        let person = GroupMemberModel(image: nil, firstName: "Петр", lastName: "Петров", description: nil)
        
        //when
        let result = statisticsModel.getPersonallyStatistics(model: startedData, person: person)
        
        
        for cell in result {
            for mark in cell.marks {
                let name = mark.person.firstName + " " + mark.person.lastName
                if name != expectedResult {
                    XCTAssert(false)
                }
            }
        }
        
        
    }
    
    
    func testBadStudentName() throws {
        
        //Given
        let expectedResult = "Петров Петр"
        let startedData = statisticsModel.fetchStatistics()
        
        
        //when
        let result = statisticsModel.badStudentVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult, result.name)
        
    }
    
    
    func testBadStudentVisitsAndPasses() throws {
        
        //Given
        let expectedResult = VisitsAndPasses(visits: 0, passes: 4)
        let startedData = statisticsModel.fetchStatistics()
        
        //when
        let result = statisticsModel.badStudentVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult.visits, result.visitsAndPasses.visits)
        XCTAssertEqual(expectedResult.passes, result.visitsAndPasses.passes)
        
    }
    
    func testBestStudentName() {
        //Given
        let expectedResult = "Яндола Влад"
        let startedData = statisticsModel.fetchStatistics()
        
        
        //when
        let result = statisticsModel.bestStudentVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult, result.name)
    }
    
    
    func testBestStudentVisitsAndPasses() throws {
        
        //Given
        let expectedResult = VisitsAndPasses(visits: 3, passes: 1)
        let startedData = statisticsModel.fetchStatistics()
        
        //when
        let result = statisticsModel.bestStudentVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult.visits, result.visitsAndPasses.visits)
        XCTAssertEqual(expectedResult.passes, result.visitsAndPasses.passes)
        
    }
    
    func testBestSubjectName() {
        //Given
        let expectedResult = "Математическая статистика"
        let startedData = statisticsModel.fetchStatistics()
        
        
        //when
        let result = statisticsModel.bestSubjectVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult, result.name)
    }
    
    func testBestSubjectVisitsAndPasses() throws {
        
        //Given
        let expectedResult = VisitsAndPasses(visits: 2, passes: 2)
        let startedData = statisticsModel.fetchStatistics()
        
        //when
        let result = statisticsModel.bestSubjectVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult.visits, result.visitsAndPasses.visits)
        XCTAssertEqual(expectedResult.passes, result.visitsAndPasses.passes)
        
    }
    
    func testBadSubjectName() {
        //Given
        let expectedResult = "Электротехника и электроника"
        let startedData = statisticsModel.fetchStatistics()
        
        
        //when
        let result = statisticsModel.badSubjectVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult, result.name)
    }
    
    func testBadSubjectVisitsAndPasses() throws {
        
        //Given
        let expectedResult = VisitsAndPasses(visits: 1, passes: 3)
        let startedData = statisticsModel.fetchStatistics()
        
        //when
        let result = statisticsModel.badSubjectVisitsAndPasses(model: startedData)
        
        XCTAssertEqual(expectedResult.visits, result.visitsAndPasses.visits)
        XCTAssertEqual(expectedResult.passes, result.visitsAndPasses.passes)
        
    }
    

}
