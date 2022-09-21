//
//  ViewController.swift
//  iPub
//
//  Created by admin on 09.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalSelled: UILabel!
    
    @IBOutlet weak var margin: UILabel!
    
    @IBOutlet var beerNames: [UILabel]!
    
    @IBOutlet var beerCountries: [UILabel]!
    
    @IBOutlet var remains: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<PubManager.shared.beers.count {
            beerNames[index].text = PubManager.shared.beers[index].name
            beerCountries[index].text = PubManager.shared.beers[index].country
            updateRemains(for: index)
            updateMargin()
            updateSelled()
            
        }
        
    }
    
    func updateRemains(for index: Int) {
        let volume = PubManager.shared.beers[index].remain
        remains[index].text = "Остаток\n\(volume) л"
    }
    
    func updateMargin() {
        let newMargin = PubManager.shared.margin
        
        margin.text = "Выручка за день: \(newMargin) руб"
    }
    
    func updateSelled() {
        let selled = PubManager.shared.totalSelled
        
        totalSelled.text = "Продано пива: \(selled) л"
    }
    
    
    @IBAction func buyBeer(_ sender: UIButton) {
    
        let tag = sender.tag
        let beerIndex = tag / 10
        let volume: Double
    
    switch tag % 10 {
    case 0:
        volume = 0.33
    case 1:
        volume = 0.5
    case 2:
        volume = 1
    default:
        volume = 0
    }
        
        let price = PubManager.shared.buyBeer(index: beerIndex, volume: volume)
        print(price)
        
        showAlert(withPrice: price, index: beerIndex)
    
        updateRemains(for: beerIndex)
        updateMargin()
        updateSelled()
    }
    
    
    
   func showAlert(withPrice price: Double, index: Int) {
       let currentRemain = PubManager.shared.beers[index].remain
        if price == -1 {
            showAlert(withTitle: "Неудачная покупка", message: "Не хватает пива. Остаток: \(currentRemain) л")
        } else {
            showAlert(withTitle: "Удачная покупка", message: "Сумма покупки \(price) руб. Остаток: \(currentRemain) л")
        }
    }
    
    func showAlert(withTitle title: String, message: String) {
        // создание сущности алерта (новый экран для показа)
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        // Создание кнопки для алерта
        let action = UIAlertAction(title: "OK", style: .default)
        // добавление кнопки к алерту
        alert.addAction(action)
        
        // показ алерта
        present(alert, animated: true)
    }
    
    @IBAction func StartNewDay(_ sender: UIButton) {
       
        
        showAlert(withTitle: "НОВАЯ СМЕНА ОТКРЫТА", message: "Выручка за предыдущий день составила \(PubManager.shared.margin) руб. Было продано пива \(PubManager.shared.totalSelled) л ")
        
        PubManager.shared.margin = 0
        updateMargin()
        PubManager.shared.totalSelled = 0
        updateSelled()
        

    }
    }
    


