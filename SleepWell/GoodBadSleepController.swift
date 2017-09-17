//
//  GoodBadSleepController.swift
//  SleepWell
//
//  Created by Katharine on 2017-09-17.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit

class GoodBadSleepController: UIViewController {
    
    @IBOutlet weak var bestAvgLength: UILabel!
    @IBOutlet weak var bestCups: UILabel!
    @IBOutlet weak var bestExercise: UILabel!
    
    @IBOutlet weak var bestAvgLengthValue: UILabel!
    @IBOutlet weak var bestCupsValue: UILabel!
    @IBOutlet weak var bestExerciseValue: UILabel!
    
    @IBOutlet weak var worstAvgLength: UILabel!
    @IBOutlet weak var worstCups: UILabel!
    @IBOutlet weak var worstExercise: UILabel!
    
    @IBOutlet weak var worstAvgLengthValue: UILabel!
    @IBOutlet weak var worstCupsValue: UILabel!
    @IBOutlet weak var worstExerciseValue: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        var bestEntries = loadEntries()
        var worstEntries = bestEntries
        
        if ((bestEntries?.count)! > 5) {
            bestEntries?.sort(by: sortEntriesBest)
            worstEntries?.sort(by: sortEntriesWorst)
        
            var top5BestEntries = bestEntries![0...4]
            var top5WorstEntries = worstEntries![0...4]
            
            var bestTimes: [Int] = [Int]()
            for entry in top5BestEntries {
                bestTimes.append(getTotalSleepTimeInMinutes(start: entry.startSleepTime, end: entry.endSleepTime))
            }
            var worstTimes: [Int] = [Int]()
            for entry in top5WorstEntries {
                worstTimes.append(getTotalSleepTimeInMinutes(start: entry.startSleepTime, end: entry.endSleepTime))
            }
            
            bestAvgLength.text = calculateAvg(array: bestTimes).description
            worstAvgLength.text = calculateAvg(array: worstTimes).description
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func calculateAvg(array: [Int]) -> Float {
        var sum = 0
        for i in 0  ..< array.count {
            sum += array[i]
        }
        return Float(sum/array.count)
        
    }
    
    private func loadEntries() -> [SleepEntry]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SleepEntry.ArchiveURL.path) as? [SleepEntry]
    }
    
    func sortEntriesBest(this:SleepEntry, that:SleepEntry) -> Bool {
        if (this.qualityRating == that.qualityRating) {
            return getTotalSleepTimeInMinutes(start: this.startSleepTime, end: this.endSleepTime) < getTotalSleepTimeInMinutes(start: that.startSleepTime, end: that.endSleepTime)
        } else {
            return this.qualityRating < that.qualityRating
        }
    }
    
    func sortEntriesWorst(this:SleepEntry, that:SleepEntry) -> Bool {
        if (this.qualityRating == that.qualityRating) {
            return getTotalSleepTimeInMinutes(start: this.startSleepTime, end: this.endSleepTime) > getTotalSleepTimeInMinutes(start: that.startSleepTime, end: that.endSleepTime)
        } else {
            return this.qualityRating > that.qualityRating
        }
    }
    
    private func getTotalSleepTimeInMinutes(start: Date, end: Date) -> Int {
        let durationInSeconds = Int(end.timeIntervalSince(start))
        return durationInSeconds / 60
        
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
