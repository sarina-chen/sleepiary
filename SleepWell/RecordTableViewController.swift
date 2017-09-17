//
//  RecordTableViewController.swift
//  SleepWell
//
//  Created by Kirsten Howard on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit

class RecordTableViewController: UITableViewController {
	
	var records = [SleepEntry]();

    override func viewDidLoad() {
        super.viewDidLoad()
		
		loadRecords()
		
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cellIdentifier = "RecordTableViewCell"
		
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecordTableViewCell else {
			fatalError("The cell is not an instance of RecordTableViewCell")
		}

		let record = records[indexPath.row]
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateFormatter.timeStyle = .none
		
		cell.dateLabel.text = dateFormatter.string(from: record.getDate())
		cell.photoImageView.image = getImageForRating(record.getQualityRating())
		
        return cell
    }
	
	func getImageForRating(_ rating: Int) -> UIImage {
		let photo1 = UIImage(named: "FaceImage")
		let photo2 = UIImage(named: "PatternImage")
		
		if (rating < 3) {
			return photo1!
		}
		return photo2!
	}


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
		
		guard let selectedRecordCell = sender as? RecordTableViewCell else {
			fatalError("Unexpected sender")
		}
		
		guard let indexPath = tableView.indexPath(for: selectedRecordCell) else {
			fatalError("Selected cell is not being displayed by table")
		}
		
		guard let recordDetailViewController = segue.destination as? RecordDetailViewController else {
			fatalError("Unexpected destination")
	}
	
		let selectedRecord = records[indexPath.row]
		recordDetailViewController.record = selectedRecord
    }
	
	private func loadRecords() {
		let retrievedRecords = (NSKeyedUnarchiver.unarchiveObject(withFile: SleepEntry.ArchiveURL.path) as? [SleepEntry])
		if (retrievedRecords != nil) {
			records += retrievedRecords!
		}
		records += []
	}
	

	private func loadSampleRecords() {
		
		let record1 = SleepEntry(date: Date(timeIntervalSinceReferenceDate: 123456789), start: Date(timeIntervalSinceReferenceDate: 123450000), end: Date(timeIntervalSinceReferenceDate: 123460000), quality: 5, coffee: 2, exerciseMinutes: 30)
		let record2 = SleepEntry(date: Date(timeIntervalSinceReferenceDate: 1234567891), start: Date(timeIntervalSinceReferenceDate: 123455000), end: Date(timeIntervalSinceReferenceDate: 123456000), quality: 2, coffee: 0, exerciseMinutes: 0)
		let record3 = SleepEntry(date: Date(timeIntervalSinceReferenceDate: 1123456789), start: Date(timeIntervalSinceReferenceDate: 1123456000), end: Date(timeIntervalSinceReferenceDate: 1123459000), quality: 1, coffee: 4, exerciseMinutes: 20)
		
		records += [record1,record2,record3]
	}
	
}
