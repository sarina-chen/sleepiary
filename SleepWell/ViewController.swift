//
//  ViewController.swift
//  SleepWell
//
//  Created by Sarina Chen on 2017-09-16.
//  Copyright © 2017 Sc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var thankfulQuestion: UILabel!
    @IBOutlet weak var addThankfulTextButton: UIButton!
    @IBOutlet weak var thankfulTextView: UITextView!
    
    @IBOutlet weak var thankfulTextsTableView: UITableView!
    @IBOutlet weak var inspiringQuote: UILabel!
    
    // TODO: Where to store this data?
    var thankfulTexts = [ThankfulText]()
    
    override func viewDidLoad() {
        thankfulTextView.delegate = self
        addThankfulTextButton.isEnabled = false
        if thankfulTexts.isEmpty{
            inspiringQuote.isHidden = false
            thankfulTextsTableView.isHidden = true
        }else{
            inspiringQuote.isHidden = true
            thankfulTextsTableView.isHidden = false
            displayThankfulTexts()
            
        }
        
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
    
    
    @IBAction func addThankfulText(_ sender: Any) {
        let currDate = Date()
        let newThankfulText = ThankfulText(msg: thankfulTextView.text, date: currDate)
        thankfulTexts.append(newThankfulText!)
        displayThankfulTexts()
        
    }
    
    @IBAction func viewHistory(_ sender: Any) {
        
    }
    
    @IBAction func addEntry(_ sender: Any) {
    }
    
    func displayThankfulTexts(){
        thankfulTextsTableView.beginUpdates()
        let indexPath:IndexPath = IndexPath(row:(self.thankfulTexts.count - 1), section:0)
        thankfulTextsTableView.insertRows(at: [indexPath], with: .left)
        thankfulTextsTableView.endUpdates()
        
        thankfulTextsTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if !thankfulTextView.text.isEmpty{
            addThankfulTextButton.isEnabled = true
        }else{
            addThankfulTextButton.isEnabled = false
        }
    }
    

}

