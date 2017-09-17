//
//  SleepEntry.swift
//  SleepWell
//
//  Created by Katharine on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

class SleepEntry {
    var startSleepTime: UIDatePicker;
    var endSleepTime: UIDatePicker;
    
    init(start: UIDatePicker, end: UIDatePicker) {
        self.startSleepTime = start
        self.endSleepTime = end
    }
}

import UIKit
