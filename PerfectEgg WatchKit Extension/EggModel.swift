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

    
    mutating func select(card: Card) {
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
            let boilTime = (Int("\(content)") ?? 0) * 1 //TODO: Change to 60
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
    }

}
