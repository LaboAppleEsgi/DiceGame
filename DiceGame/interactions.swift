//
//  interactions.swift
//  DiceGame
//
//  Created by David Linhares on 29/11/2018.
//  Copyright © 2018 David Linhares. All rights reserved.
//

import Foundation

func getPlayers() -> Int {
    var players = 0

    repeat {
        print("How many players will play ?")
        players = Int(readLine() ?? "0") ?? 0
    } while players < 1

    return players
}

func getPot(for player: Int) -> Int {
    var pot = 0

    repeat {
        print("player \(player + 1) pot: ")
        pot = Int(readLine() ?? "0") ?? 0
    } while pot < 1

    return pot
}

func printDice(result: Int) {
    print("....\(result)....")
}

func getPlayerBet(for player: Int, pot: Int) -> (bet: Int, diceValue: Int) {
    var bet = 0
    var diceNumber = 0

    print("--- player \(player + 1) ---")

    repeat {
        print("dice number (1-6): ")
        diceNumber = Int(readLine() ?? "0") ?? 0
    } while diceNumber < 1 || diceNumber > 7

    repeat {
        print("bet: ")
        bet = Int(readLine() ?? "0") ?? 0
    } while bet < 1 || bet > pot

    return (bet, diceNumber)
}

func printPlayerBetResult(player: Int, win: Int) {
    win > 0 ? print("player \(player + 1) wins: \(win)") : print("player \(player + 1) loose: \(win * -1)")
}

func isPlayerContinuing(player: Int) -> Bool {
    var answer = ""

    repeat {
        print("player \(player + 1) continue/quit (c/q): ")
        answer = readLine()?.lowercased() ?? ""
    } while answer != "c" && answer != "q"

    return answer == "c"
}

func isPlayerRebuy(player: Int) -> Bool {
    var answer = ""

    repeat {
        print("player \(player + 1) you loose want to rebuy (y/n): ")
        answer = readLine()?.lowercased() ?? ""
    } while answer != "y" && answer != "n"

    return answer == "y"
}
