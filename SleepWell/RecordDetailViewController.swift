//
//  RecordDetailViewController.swift
//  SleepWell
//
//  Created by Kirsten Howard on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit

class RecordDetailViewController: UIViewController {
	
	var record: SleepEntry?
	
	@IBOutlet weak var ratingValue: UILabel!
	
	@IBOutlet weak var startValue: UILabel!
	
	@IBOutlet weak var endValue: UILabel!
	
	@IBOutlet weak var totalValue: UILabel!
	
	@IBOutlet weak var drinksValue: UILabel!
	
	@IBOutlet weak var minutesValue: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		
		navigationItem.title = dateFormatter.string(for: record!.getDate())
		dateFormatter.dateStyle = .none
		dateFormatter.timeStyle = .medium
		
		ratingValue.text = record!.getQualityRating().description
		startValue.text = dateFormatter.string(from: record!.getStartSleepTime())
		endValue.text = dateFormatter.string(from: record!.getEndSleepTime())
		totalValue.text = getTotalSleepTime(start: record!.getStartSleepTime(), end: record!.getEndSleepTime(), formatter: dateFormatter)
		drinksValue.text = record!.getCupsCoffee().description
		minutesValue.text = record!.getExerciseMinutes().description
    }
	
	private func getTotalSleepTime(start: Date, end: Date, formatter: DateFormatter) -> String {
		let durationInSeconds = Int(end.timeIntervalSince(start))
		let durationInMinutes = durationInSeconds / 60
		
		let hours = durationInMinutes / 60
		let minutes = durationInMinutes % 60
		
		var stringToReturn = ""
		if (hours != 0) {
			stringToReturn += hours.description + " h "
		}
		if (minutes != 0) {
			stringToReturn += minutes.description + " m"
		}
		return stringToReturn
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
