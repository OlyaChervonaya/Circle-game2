//
//  PubManager.swift
//  iPub
//
//  Created by admin on 10.09.2022.
//

import Foundation

class PubManager {
    
    var beers = [
        Beer(
            name: "Grimbergen",
            country: "🇧🇪",
            price: 10,
            remain: 106
        ),
        Beer(
            name: "Guinnes",
            country: "🇮🇪",
            price: 9,
            remain: 200
        ),
        Beer(
            name: "Warsteiner",
            country: "🇩🇪",
            price: 12,
            remain: 3.5
        ),
    ]
    
    var margin = 0.0
    var totalSelled = 0.0
    
    private init () { }
    static let shared = PubManager()
    
    func buyBeer(index: Int, volume: Double) -> Double {
        if (beers[index].remain < volume) {return -1}
        
        beers[index].remain -= volume
        beers[index].remain = round(beers[index].remain)
        let price = volume * Double(beers[index].price)
        
        totalSelled += volume
        totalSelled = round(totalSelled)
        
        margin += price
        margin = round(margin)
        
        return round(price)
    }
    
    func round (_ num: Double) -> Double {
        var result = num * 100
        result += 0.5
        return Double(Int(result)) / 100
    }
}
