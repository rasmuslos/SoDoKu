//
//  GameView+Clue.swift
//  SuDoKu
//
//  Created by Rasmus Krämer on 16.02.24.
//

import SwiftUI

extension GameView {
    struct ClueView: View {
        let game: Game
        
        @Binding var blockUI: Bool
        @Binding var selectedSpace: Int?
        
        var body: some View {
            if !game.eligibleForStatistics {
                Text("statistics.ineligible")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
                    .padding(.bottom, 10)
            }
            
            Button {
                let clue = game.clue()
                
                Task {
                    blockUI = true
                    
                    withAnimation {
                        selectedSpace = clue.1
                    }
                    
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    
                    withAnimation {
                        let _ = game.input(number: clue.0, index: clue.1)
                    }
                    
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    
                    withAnimation {
                        selectedSpace = nil
                    }
                    
                    blockUI = false
                }
            } label: {
                Label("clue", systemImage: "questionmark.circle.fill")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
