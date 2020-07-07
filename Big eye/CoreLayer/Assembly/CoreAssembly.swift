//
//  CoreAssembly.swift
//  Big eye
//
//  Created by Const. on 30.06.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

protocol ICoreAssembly {
    var groupFileManager: IGroupFileManager { get }
    var timetableFileManager: ITimetableFileManager { get }
    var statisticsFileManager: IStatisticsFileManager { get }
}

class CoreAssembly: ICoreAssembly {
    lazy var groupFileManager: IGroupFileManager = GroupFileManager()
    lazy var timetableFileManager: ITimetableFileManager = TimetableFileManager()
    lazy var statisticsFileManager: IStatisticsFileManager = StatisticsFileManager()
}
