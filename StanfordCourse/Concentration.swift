//
//  Concentration.swift
//  StanfordCourse
//
//  Created by Тимур Чеберда on 15/03/2019.
//  Copyright © 2019 Tmur Cheberda. All rights reserved.
//

import Foundation

class Concentration {
    // массив с картами
    private(set) var cards = [Card] ()
    // счетчик нажатий
    private(set) var flipCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    // метод выбора карты
    func chooseCard(at index: Int) {
        // Проверяем на аргументы
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        //  если поднята то опускаем
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // проверка на соответствие
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    // инцилизатор для создания кол-ва карт
    init(numbersOfPairsOfCards: Int) {
        // Проверяем на аргументы
        assert(numbersOfPairsOfCards > 0, "Concentration.init(\(numbersOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numbersOfPairsOfCards {
            // создаем карту
            let card = Card()
            // помещаем копию карты
            // другая копия карты, отличается от предыдущей копии
            cards += [card, card]
        }
        // замешиваем карты
        cards.shuffle()
    }
}
