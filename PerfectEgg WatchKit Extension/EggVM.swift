//
//  EggVM.swift
//  PerfectEgg WatchKit Extension
//
//  Created by Augusto Spinelli on 04/08/20.
//  Copyright © 2020 Augusto Spinelli. All rights reserved.
//

import SwiftUI

//Our ViewModel
class EggVM : ObservableObject {
    // Private model, only acessible by ViewModel
    @Published private var timer : EggModel<String> = EggVM.createEggs()

    
    private static func createEggs() -> EggModel<String> {
        let eggs = ["13","11","9","7","5","3"]
        return EggModel<String>(numberOfCards: eggs.count) {index in
            return eggs[index]
        }
    }
        
    
    //Expose data to views in a simple fashioned way (views must be as simple as possible)
    // MARK: - Access to the Model
    var cards : Array<EggModel<String>.Card> {
        timer.cards
    }
    
    
    // MARK: - User Intent(s)
    func select(card : EggModel<String>.Card) {
        timer.select(card: card)
    }
    
    func reset() {
        timer = EggVM.createEggs()
    }
}


