//
//  NBAStandingsView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct NBAStandingsView: View {
    @StateObject var viewModel = NBAStandingsViewModel()

    var body: some View {
        NavigationStack {
            if !viewModel.data.isEmpty {
                ScrollView {
                    ForEach(viewModel.data, id: \.self?.0.title) { item in
                        if let item {
                            StandingsHeaderView(headerData: item.0,
                                                standings: item.1)
                        }
                    }
                }

                .navigationTitle("NBA")
                .navigationBarTitleDisplayMode(.inline)

            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .task {
            await viewModel.fetchStandings()
        }
    }
}

#Preview {
    NBAStandingsView()
}
