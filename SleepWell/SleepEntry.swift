//
//  SleepEntry.swift
//  SleepWell
//
//  Created by Katharine on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

class SleepEntry {
    
    //MARK: Properties
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("sleepEntries")
    
    var date: Date;
    var startSleepTime: Date;
    var endSleepTime: Date;
    var qualityRating: Int
    var cupsCoffee: Int
    var exerciseMinutes: Int
    
    //MARK: Initialization
    init(date: Date, start: Date, end: Date, quality: Int, coffee: Int, exerciseMinutes: Int) {
        self.date = date
        self.startSleepTime = start
        self.endSleepTime = end
        self.qualityRating = quality
        self.cupsCoffee = coffee
        self.exerciseMinutes = exerciseMinutes
    }
	
	func getDate() -> Date {
		return date
	}
	
	func getStartSleepTime() -> Date {
		return startSleepTime
	}
	
	func getEndSleepTime() -> Date {
		return endSleepTime
	}
	
	func getQualityRating() -> Int {
		return qualityRating
	}
	func getCupsCoffee() -> Int {
		return cupsCoffee
	}
	
	func getExerciseMinutes() -> Int {
		return exerciseMinutes
	}
}

import UIKit
