//
//  AddEntryViewController.swift
//  SleepWell
//
//  Created by Sarina Chen on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit
import os.log

class AddEntryViewController: UIViewController {
    
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var qualityRating: UISegmentedControl!
    @IBOutlet weak var startSleep: UIDatePicker!
    @IBOutlet weak var EndSleep: UIDatePicker!
    @IBOutlet weak var coffeeStepper: UIStepper!
    @IBOutlet weak var coffeeLabel: UILabel!
    @IBOutlet weak var exerciseSlider: UISlider!
    @IBOutlet weak var exerciseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coffeeStepper.wraps = true
        coffeeStepper.autorepeat = true
        coffeeStepper.maximumValue = 10
        coffeeStepper.minimumValue = 0
        exerciseSlider.isContinuous = true
        
        exerciseLabel.text = Int(exerciseSlider.value).description
        
        let currentDate = Calendar.current
        let defaultDate = currentDate.date(byAdding: .day, value: -1, to: Date())
        
        datePicker.setDate(defaultDate!, animated: false)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Add a new entry"
    }

    @IBAction func coffeeStepperValueChanged(_ sender: UIStepper) {
        coffeeLabel.text = Int(coffeeStepper.value).description
    }
    
    @IBAction func exerciseSliderValueChanged(_ sender: UISlider) {
        let currValue = Int(sender.value)
        exerciseLabel.text = "\(currValue)"
    }
    
    private func loadEntries() -> [SleepEntry]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: SleepEntry.ArchiveURL.path) as? [SleepEntry]
    }
    
    @IBAction func saveEntry(_ sender: Any) {
        var entries = loadEntries()
        let newEntry: SleepEntry = SleepEntry.init(date: datePicker.date, start: startSleep.date, end: EndSleep.date, quality: qualityRating.selectedSegmentIndex + 1, coffee: Int(coffeeStepper.value), exerciseMinutes: Int(exerciseSlider.value))
        
        if (entries?.count == 0) {
        entries?.append(newEntry)
        } else {
            entries?.insert(newEntry, at: 0)
        }
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(entries, toFile: SleepEntry.ArchiveURL.path)
        let path = SleepEntry.ArchiveURL.path
        if isSuccessfulSave {
            os_log("Sleep entries successfully saved.", log: OSLog.default, type: .debug)
            print("\(path)")
        } else {
            os_log("Failed to save sleep entries...", log: OSLog.default, type: .error)
        }
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
