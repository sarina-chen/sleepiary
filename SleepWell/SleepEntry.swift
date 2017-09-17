//
//  SleepEntry.swift
//  SleepWell
//
//  Created by Katharine on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

class SleepEntry: NSObject, NSCoding  {
    
    //MARK: Properties
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("sleepEntries")
    
    var date: Date;
    var startSleepTime: Date;
    var endSleepTime: Date;
    var qualityRating: Int
    var cupsCoffee: Int
    var exerciseMinutes: Int
	
	//MARK: Types
	
	struct PropertyKey {
		static let date = "date"
		static let startSleepTime = "start"
		static let endSleepTime = "end"
		static let qualityRating = "rating"
		static let cupsCoffee = "cups"
		static let exerciseMinutes = "minutes"
	}
    
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
	
	
	// Data Persistence
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(_: date, forKey: PropertyKey.date)
		aCoder.encode(_: startSleepTime, forKey: PropertyKey.startSleepTime)
		aCoder.encode(_: endSleepTime, forKey: PropertyKey.endSleepTime)
		aCoder.encode(_: qualityRating, forKey: PropertyKey.qualityRating)
		aCoder.encode(_: cupsCoffee, forKey: PropertyKey.cupsCoffee)
		aCoder.encode(_: exerciseMinutes, forKey: PropertyKey.exerciseMinutes)
	}
	
	
	
	required convenience init?(coder aDecoder: NSCoder) {
		guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Date else {
			os_log("Unable to decode the date of this record.", log: OSLog.default, type: .debug)
			return nil
		}
		
		let startSleepTime = aDecoder.decodeObject(forKey: PropertyKey.startSleepTime) as? Date
		let endSleepTime = aDecoder.decodeObject(forKey: PropertyKey.endSleepTime) as? Date
		let qualityRating = aDecoder.decodeInteger(forKey: PropertyKey.qualityRating)
		let cupsCoffee = aDecoder.decodeInteger(forKey: PropertyKey.cupsCoffee)
		let exerciseMinutes = aDecoder.decodeInteger(forKey: PropertyKey.exerciseMinutes)

		self.init(date: date, start: startSleepTime!, end: endSleepTime!, quality: qualityRating, coffee: cupsCoffee, exerciseMinutes: exerciseMinutes)
	}
}

import UIKit
import os.log
