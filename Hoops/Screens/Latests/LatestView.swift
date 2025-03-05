//
//  LatestView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct LatestView: View {
    @StateObject private var viewModel = LatestViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.loading {
                    ProgressView()
                        .progressViewStyle(.circular)

                } else {
                    scrollView
                }
            }
            .navigationTitle("Latest")
            .background(Color.secondarySystemBackground)
            .task {
                await viewModel.fetchLatest()
            }
        }
    }

    private var scrollView: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("LATEST GAMES")
                    .font(.headline.weight(.thin))
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(viewModel.latestGames) { game in
                            GameResultView(data: game)
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 20)
                .scrollIndicators(.hidden)
            }

            VStack(alignment: .leading) {
                Text("TOP PERFORMERS")
                    .font(.headline.weight(.thin))
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                TopPerformersView(data: viewModel.topPerformers)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 4)
                    .background(Color.systemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
            }

            VStack(alignment: .leading) {
                Text("STAT LEADERS")
                    .font(.headline.weight(.thin))
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                StatLeadersView(data: viewModel.statLeaders)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 4)
                    .background(Color.systemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    LatestView()
}
