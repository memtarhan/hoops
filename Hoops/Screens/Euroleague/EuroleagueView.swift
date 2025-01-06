//
//  EuroleagueView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct EuroleagueView: View {
    @StateObject private var viewModel = EuroleagueViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.loading {
                    ProgressView()
                        .progressViewStyle(.circular)

                } else {
                    contentView
                }
            }
            .navigationTitle("Euroleague")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.secondarySystemBackground)
            .task {
                await viewModel.handleData()
            }
        }
    }
    
    var contentView: some View {
        VStack(spacing: 8) {
            LatestGamesView(data: viewModel.scores)
            EuroleagueStandingsView(data: viewModel.standings)
        }
    }
}

#Preview {
    EuroleagueView()
}
