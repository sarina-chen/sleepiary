//
//  ThankfulText.swift
//  SleepWell
//
//  Created by Sarina Chen on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import Foundation
import UIKit
import os.log

class ThankfulText : NSObject, NSCoding{
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("thankfulTexts")
    
    var message: String
    var date: Date
    
    //MARK: Types
    struct PropertyKey{
        static let message = "message"
        static let date = "date"
    }
    
    init?(msg: String, date: Date){
        let currentDate = Date()
        
        guard !msg.isEmpty else{
            return nil
        }
        
        guard date != currentDate else{
            return nil
        }
        
        self.message = msg
        self.date = date

    }
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(message, forKey: PropertyKey.message)
        aCoder.encode(date, forKey: PropertyKey.date)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let message = aDecoder.decodeObject(forKey: PropertyKey.message) as? String else{
            os_log("Unable to decode the message for a ThankfulText object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let date = aDecoder.decodeObject(forKey: PropertyKey.date)
        
        self.init(msg: message, date: date as! Date)
    
    }
    

}
