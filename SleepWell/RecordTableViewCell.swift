//
//  RecordTableViewCell.swift
//  SleepWell
//
//  Created by Kirsten Howard on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var photoImageView: UIImageView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
