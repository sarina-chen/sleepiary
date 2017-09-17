//
//  ViewController.swift
//  SleepWell
//
//  Created by Sarina Chen on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit
import os.log
import UserNotifications

class ViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var sleepTime: UIDatePicker!

    @IBOutlet weak var thankfulQuestion: UILabel!
    @IBOutlet weak var addThankfulTextButton: UIButton!
    @IBOutlet weak var thankfulTextView: UITextView!
    @IBOutlet weak var quote: UITextView!
    
    var thankfulTextsToday = [ThankfulText]()
    
    override func viewDidLoad() {
        let color = UIColor(red:0.81, green:0.81, blue:0.91, alpha:1.0)
        quote.layer.borderColor = color.cgColor
        quote.layer.borderWidth = 2.0
        quote.text = "Enjoy the little things, for one day you may look back and realize they were the big things. \n \n - Robert Brault"
        thankfulTextView.delegate = self
        
        displayThankfulTexts()
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func triggerNotification(date: Date){
        print("sending notification")
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options){
            (grant, error) in if !grant{
                print("notification went wrong")
            }
        }
        
        let notification = UNMutableNotificationContent()
        notification.title = "Sleep time in 35 minutes"
        notification.body = "Reminder to complete your sleep diary then stay away from screen 30 minutes before bedtime."
        notification.sound = UNNotificationSound.default()
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: notification, trigger: trigger)
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("notification trigger failed")
            }
        })
    
    
    }

    private func loadSavedThankfulTexts() -> [ThankfulText]? {
        let savedThankfulTexts = NSKeyedUnarchiver.unarchiveObject(withFile: ThankfulText.ArchiveURL.path) as? [ThankfulText]
        if savedThankfulTexts != nil {
            return savedThankfulTexts
        }else{
            return []
        }
        
    }
    
    @IBAction func saveSleepTime(_ sender: Any) {
        let date = Date(timeInterval: -2100, since: sleepTime.date)
        triggerNotification(date: date)
    }

    
    @IBAction func addThankfulText(_ sender: Any) {
        if thankfulTextView.text == ""{
            return
        }else{
            let currDate = Date()
            var savedThankfulTexts = loadSavedThankfulTexts()
            let newThankfulText = ThankfulText(msg: thankfulTextView.text, date: currDate)
            savedThankfulTexts?.insert(newThankfulText!, at: 0)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(savedThankfulTexts, toFile: ThankfulText.ArchiveURL.path)
            let path = ThankfulText.ArchiveURL.path
            if isSuccessfulSave {
                os_log("Thankful texts successfully saved.", log: OSLog.default, type: .debug)
                print("\(path)")
            } else {
                os_log("Failed to thankful texts...", log: OSLog.default, type: .error)
            }
            thankfulTextsToday.append(newThankfulText!)
            thankfulTextView.text = ""
            displayThankfulTexts()
        
        }
        
        
    }
    
    @IBAction func viewHistory(_ sender: Any) {
        
    }
    
    @IBAction func addEntry(_ sender: Any) {
    }
    
    func displayThankfulTexts(){
        let savedThankfulTexts = loadSavedThankfulTexts()
        var appendedMsg = ""
        if !(savedThankfulTexts?.count == 0 && thankfulTextsToday.isEmpty){
            for thankfulText in savedThankfulTexts!{
                if thankfulText.date == Date(){
                    appendedMsg += thankfulText.message + "\n"
                }
            
            }
            for thankfulText in thankfulTextsToday{
                appendedMsg += thankfulText.message + "\n"
                
            }
            quote.text = "Today I'm thankful for: \n \n" + appendedMsg
        }
    }
/*
    func textViewDidEndEditing(_ textView: UITextView) {
        if !thankfulTextView.text.isEmpty{
            addThankfulTextButton.isEnabled = false
        }else{
            addThankfulTextButton.isEnabled = true
        }
    }
 */
    

}

