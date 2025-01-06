//
//  ContentView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LatestView()
                .tabItem {
                    Label("Latest", systemImage: "basketball.fill")
                }
                .tag(0)

            NBAStandingsView()
                .tabItem {
                    Label("NBA", systemImage: "basketball.fill")
                }
                .tag(1)

            NBAScoresView()
                .tabItem {
                    Label("Scores", systemImage: "basketball.circle.fill")
                }
                .tag(2)

            EuroleagueView()
                .tabItem {
                    Label("Euroleague", systemImage: "globe.europe.africa.fill")
                }
                .tag(3)
            
            LeaguesView()
                .tabItem {
                    Label("Leagues", systemImage: "globe")
                }
                .tag(4)
            
        }
    }
}

#Preview {
    ContentView()
}
