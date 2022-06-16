//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Johnny Huynh on 6/15/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showResult = false
    @State private var finalScore = false
    @State private var handResult = ""
    @State private var score = 0
    @State private var rounds = 0
    @State var cpuHand = Int.random(in: 0...2)
    
    @State var hands = ["Rock", "Paper", "Scissors"]
    @State var winningHands = ["Paper", "Scissors", "Rock"]
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .green]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 20) {
                    Text("Round \(rounds+1)/3")
                        .font(.largeTitle)
                    Text("Score: \(score)")
                }
                
                ForEach(0..<3) { number in
                    Button {
                        handChosen(number)
                    } label: {
                        Text("\(hands[number])")
                    }
                }
            }
        }
        .alert(handResult, isPresented: $showResult) {
            Button("Next Round", action: nextHand)
        } message: {
            Text("Your opponent played \(hands[cpuHand])")
        }
        .alert(handResult, isPresented: $finalScore) {
            Button("Restart Game", action: reset)
        } message: {
            Text("Final Score: \(score) \nYour opponent played \(hands[cpuHand])")
        }
        
    }
    
    //Functions
    func handChosen(_ number: Int) {
        
        if (number == cpuHand) {
            //Tie
            handResult = "Draw!"
        } else if (winningHands[number] == hands[cpuHand]) {
            //CPU wins
            handResult = "You lost!"
        } else {
            //Player wins
            handResult = "You won!"
            //Add points to score
            score += 1
        }
        
        if (rounds == 2) {
            handResult += " Game Ended."
            finalScore = true
        } else {
            showResult = true
        }

    }
    
    func nextHand() {
        //New cpu hand
        cpuHand = Int.random(in: 0...2)
        
        //Increment round counter
        rounds += 1
    }
    
    func reset() {
        //New Hand
        nextHand()
        
        //Initialize values
        showResult = false
        finalScore = false
        handResult = ""
        score = 0
        rounds = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
