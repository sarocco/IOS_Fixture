//
//  ViewController.swift
//  primerEtapaObligatorio
//
//  Created by SP08 on 19/4/18.
//  Copyright © 2018 UCUDAL. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  
    //Outlet tableView
    @IBOutlet weak var tableView: UITableView!
    
    //Array of empty matches objects
    var matches:[Match] = []
    
    //constructor
    override func viewDidLoad() {
        super.viewDidLoad()
        //Loads the matches array with all the data of the MainClassData
        matches = MainClassData.loadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMatch", for:indexPath) as? MainCellTableViewCell
        
        // Access to each Match and displays the data of each match in one row of the table
        let match = matches[indexPath.row]
        cell?.labelDate.text = Utils.convertFormater(inputShow: match.date!, newFormat: "dd 'de' MMMM '-' HH:mm")
        cell?.labelStadium.text = match.stadium.name
        cell?.labelGroup.text = match.group
        cell?.labelCountryOne.text = match.countryA.name
        //Search for the image in the Assets folder with that name
        cell?.pictureCountryOne.image = UIImage(named: match.countryA.shield)
        cell?.labelCountryTwo.text = match.countryB.name
        cell?.pictureCountryTwo.image = UIImage(named: match.countryB.shield)
        let goals = Utils.getGoals(match: match)
        if (Utils.compareDate(date: match.date!)){
            //Identify who is the winner to bold the result
            if (goals.0 > goals.1){
                cell?.labelResultA.font = UIFont.boldSystemFont(ofSize: 16.0)
            }else if (goals.1 > goals.0){
                cell?.labelResultB.font = UIFont.boldSystemFont(ofSize: 16.0)
            }else{
                cell?.labelResultA.font = UIFont.boldSystemFont(ofSize: 16.0)
                cell?.labelResultB.font = UIFont.boldSystemFont(ofSize: 16.0)
            }
            cell?.labelResultA.text = "- " + String(goals.0)
            cell?.labelResultB.text = String(goals.1) + " -"
        }else {
            cell?.labelResultA.text = " "
            cell?.labelResultB.text = " "
        }
        return cell!
    }
    
    //return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    //Set the height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //Send the information of match you select to the next controller: MatchViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let match = matches[indexPath.row]
        let vController = storyboard?.instantiateViewController(withIdentifier: "IdentifierMatchViewController") as? MatchViewController
        self.navigationController?.pushViewController(vController!, animated: true)
        vController?.match = match
        vController?.eventsCountryA = match.eventA
        vController?.eventsCountryB = match.eventB
    }
    
    //Deslect the selected row when go back fron MatchViweController to ViewController
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        


}

