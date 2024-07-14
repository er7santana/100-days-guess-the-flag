//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 14/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Spain",
        "UK",
        "Ukraine",
        "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingGameOver = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var answeredQuestions = 0
        
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack {
                    
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 15) {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game over", isPresented: $showingGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Final score: \(score)")
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong!"
        }
        
        scoreMessage = "That's the flag of \(countries[number])"
        
            showingScore = true
            answeredQuestions += 1
    }
    
    func askQuestion() {
        guard answeredQuestions < 8 else {
            showingGameOver = true
            return
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        score = 0
        answeredQuestions = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
