//
//  TodayViewController.swift
//  Widget
//
//  Created by Jason Crawford on 3/9/17.
//  Copyright © 2017 Jason Crawford. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var words = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add "Show More/Show Less" button in widget
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        
        if let defaults = UserDefaults(suiteName: "group.com.DaxApps.MyPolyglot") {
            if let savedWords = defaults.object(forKey: "Words") as? [String] {
                
                words = savedWords
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        
        cell.textLabel?.text = split[0]
        
        cell.detailTextLabel?.text = ""
        
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView!.backgroundColor = UIColor(white: 1, alpha: 0.20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath) {
            
            if cell.detailTextLabel?.text == "" {
                let word = words[indexPath.row]
                let split = word.components(separatedBy: "::")
                
                cell.detailTextLabel?.text = split[1]
                
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
    }
    
    // Allows Widget to expand with info when "Show More" button is pressed
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        
        if activeDisplayMode == .compact {
            preferredContentSize = CGSize(width: 0, height: 110)
        } else {
            preferredContentSize = CGSize(width: 0, height: 440)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
