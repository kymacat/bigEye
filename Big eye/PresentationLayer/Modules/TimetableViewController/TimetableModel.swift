//
//  TimetableModel.swift
//  Big eye
//
//  Created by Const. on 04.07.2020.
//  Copyright © 2020 Oleginc. All rights reserved.
//

import Foundation

struct TimetableModel {
    let name: String
    let subjects: [TimetableRowModel]
}

struct TimetableRowModel {
    let startTime: String
    let endTime: String
    let teacher: String
    let subjectNeme: String
}
