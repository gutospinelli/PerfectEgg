//
//  EggModel.swift
//  PerfectEgg WatchKit Extension
//
//  Created by Augusto Spinelli on 04/08/20.
//  Copyright © 2020 Augusto Spinelli. All rights reserved.
//

import SwiftUI

struct EggModel<CardContent> where CardContent : Equatable
{
    private (set) var cards : Array<Card>

    
    mutating func goToNextEgg() {
        cards.popLast()
        
        if let newOnScreenIndex = cards.last?.id {
            cards[newOnScreenIndex].onScreen = true
        }
    }
    
    
    init(numberOfCards : Int, cardContentFactory : (Int) -> CardContent)
    {
        cards = Array<Card>() //empty array of cards
        for index in 0..<numberOfCards
        {
            let content = cardContentFactory(index)
//            let boilTime = (Int("\(content)") ?? 0) * 1 //TODO: Change to below
            let boilTime = (index == numberOfCards-1) ? 180 : 120
            let onScreen = (index == numberOfCards-1) ? true : false
            
            cards.append(Card(content: content, id: index, img: Image("eggtime\(content)"), boilTimeInSeconds: boilTime, onScreen: onScreen))
        }
    }
    
    struct Card : Identifiable
    {
        var content : CardContent
        var id: Int
        var img : Image
        var boilTimeInSeconds : Int
        var onScreen : Bool
        
        //how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, Double(boilTimeInSeconds) - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (boilTimeInSeconds > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/Double(boilTimeInSeconds) : 0
        }
    }

}
