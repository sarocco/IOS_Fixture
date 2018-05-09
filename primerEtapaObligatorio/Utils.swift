//
//  Utils.swift
//  primerEtapaObligatorio
//
//  Created by SP08 on 9/5/18.
//  Copyright © 2018 UCUDAL. All rights reserved.
//

import UIKit

class Utils: Swift {
    
    //For one match return the goals from the CountryA and CountryB
    static func getGoals (match: Match) -> (Int,Int) {
        var goalsA: Int = 0
        var goalsB: Int = 0
        for event in match.eventA! {
            if event.icon == "⚽️" {
                goalsA = goalsA + 1
            }
        }
        for event in match.eventB! {
            if event.icon == "⚽️" {
                goalsB = goalsB + 1
            }
        }
        return (goalsA, goalsB)
    }
    
    //Compare today with the match date
    static func compareDate(date:String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_UY")
        dateFormatter.dateFormat = "dd 'de' MMMM yyyy HH:mm"
        // Create a date object from the string
        if let date = dateFormatter.date(from: date) {
            if date <= Date() {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    //Convert Date format
    static func convertFormater (inputShow: String , newFormat: String )-> String{
        let inputFormatter = DateFormatter()
        inputFormatter.locale = Locale(identifier: "es_UY")
        inputFormatter.dateFormat = "dd 'de' MMMM yyyy HH:mm"
        
        let outputFormatter = DateFormatter()
        outputFormatter.locale = Locale(identifier: "es_UY")
        outputFormatter.dateFormat = newFormat
        
        let showDate = inputFormatter.date(from: inputShow)
        let resultString = outputFormatter.string(from: showDate!)
        return resultString
    }
    

}
