//
//  MemoryGame.swift
//  CS193P-Memorize
//
//  Created by LittleJian on 4/22/22.
//

import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfTheFaceUpCard: Int? {
        // using computed property make program less buggy
        // but it's also slower, I don't know which one is better
        
        get { cards.indices.filter({ cards[$0].isFaceUp}).theOnlyValue }
        set { cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue)}) }
    }

    let title: String
    let color: Color
    var numberOfExistingCards: Int
    var tapCount: Int = 0
    var score: Int = 0

    init(number: Int, title: String, color: Color, creatCardContent: (Int) -> CardContent) {
        cards = (0..<number).flatMap { i in
            [ Card(content: creatCardContent(i), id: i * 2)
            , Card(content: creatCardContent(i), id: i * 2 + 1)]
        }.shuffled()
        self.title = title
        self.color = color
        numberOfExistingCards = number
    }

    mutating func choose(_ card: Card) -> Bool {
        // return true if the game is over
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let theOtherChosenIndex = indexOfTheFaceUpCard ,
               cards[chosenIndex].content == cards[theOtherChosenIndex].content
            {
                [chosenIndex, theOtherChosenIndex].forEach { cards[$0].isMatched = true }
                numberOfExistingCards -= 1
                score += 2
            } else {
                indexOfTheFaceUpCard = chosenIndex
            }

            if (cards[chosenIndex].isFlipped) {
                score -= 1;
            }
            tapCount += 1

            cards[chosenIndex].isFlipped = true
        }
        return numberOfExistingCards == 0
    }

    struct Card : Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isFlipped: Bool = false
        let content: CardContent
        let id: Int
    }
}

struct Theme<Content> where Content: Equatable {
    let themeName: String
    private let contents: [Content]
    let color: Color

    func getContents(number: Int) -> [Content] {
        Array(contents.shuffled().prefix(number))
    }

    init(name: String, color: Color, contents: [Content]) {
        themeName = name
        self.contents = contents
        self.color = color
    }
}

extension Array {
    var theOnlyValue: Element? {
        self.count == 1 ? self.first : nil
    }
}
