//
//  main.swift
//  DiceGame
//
//  Created by David Linhares on 29/11/2018.
//  Copyright © 2018 David Linhares. All rights reserved.
//

import Foundation

var players: [Int: Int] = [:]
let totalPlayers = getPlayers()

//initialise players and pots
for player in 0 ..< totalPlayers {
    players[player] = getPot(for: player)
}

while(players.count > 1) {
    // get players bets
    var currentBets: [Int: (bet: Int,diceValue: Int)] = [:]
    for player in 0 ..< totalPlayers {
        guard let pot = players[player] else { //check if key is not nil
            fatalError()
        }
        currentBets[player] = getPlayerBet(for: player, pot: pot)
    }
    
    //Launch dice
    let dice = Int.random(in: 1 ... 6)
    printDice(result: dice)

    // Check bets results
    players.forEach { (player: Int, pot: Int) in
        guard
            let bet = currentBets[player],
            let pot = players[player]
            else {
                fatalError()
        }

        var win = bet.bet
        if bet.diceValue == dice {
            if bet.bet < Int(pot/4) {
                win *= 2
                players[player] = win
            } else if (bet.bet > Int(pot/4) && bet.bet > Int(pot/2)) {
                win *= 3
                players[player] = win
            } else if (bet.bet < pot) {
                win *= 4
                players[player] = win
            } else {
                win *= 6
                players[player] = win
            }
        } else {
            players[player] = pot - win
            win *= -1
        }

        printPlayerBetResult(player: player, win: win)

        if players[player]! <= 0 {
            if (isPlayerRebuy(player: player)) {
                players[player] = getPot(for: player)
            } else {
                players.removeValue(forKey: player)
            }
        }
    }

    //ask player to continue
    players = players.filter { isPlayerContinuing(player: $0.key) }
}
