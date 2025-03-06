//
//  LatestViewModel.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class LatestViewModel: ObservableObject, LatestService {
    @Published var loading: Bool = false
    @Published var title: String = "Latest..."
    @Published var latestGames: [GameResultModel] = []
    @Published var topPerformers: [TopPerformerModel] = []
    @Published var statLeaders: [StatLeaderModel] = []

    func fetchLatest() {
        loading = true

        Task(priority: .background) {
            if let response = try? await getLatest() {
                title = "Latest at \(response.date)"
                handleLatestGames(response: response.games)
                handleTopPerformers(response: response.topPerformers)
                handleStatLeaders(response: response.statLeaders)
                
                loading = false
                
            } else {
                loading = false
                // TODO: display error
            }
        }
    }

    private func handleLatestGames(response: [GameScoresResponse]) {
        latestGames = response.map { scoreResponse in
            let homeTeamResponse = scoreResponse.homeTeam
            let homeTeam = GameResultTeam(name: homeTeamResponse.teamName,
                                          shortName: homeTeamResponse.teamShortName,
                                          logo: homeTeamResponse.teamLogo,
                                          score: homeTeamResponse.teamScore,
                                          status: homeTeamResponse.teamStatus,
                                          periodScores: homeTeamResponse.periodScores)

            let awayTeamResponse = scoreResponse.awayTeam
            let awayTeam = GameResultTeam(name: awayTeamResponse.teamName,
                                          shortName: awayTeamResponse.teamShortName,
                                          logo: awayTeamResponse.teamLogo,
                                          score: awayTeamResponse.teamScore,
                                          status: awayTeamResponse.teamStatus,
                                          periodScores: awayTeamResponse.periodScores)

            return GameResultModel(homeTeam: homeTeam, awayTeam: awayTeam, color: scoreResponse.color)
        }
    }

    private func handleTopPerformers(response: [TopPerformerResponse]) {
        topPerformers = response
            .map { TopPerformerModel(
                playerName: $0.playerName,
                points: $0.rebounds,
                rebounds: $0.rebounds,
                assists: $0.assists
            )
            }
    }

    private func handleStatLeaders(response: [StatLeaderResponse]) {
        statLeaders = response
            .map {
                StatLeaderModel(
                    playerName: $0.playerName,
                    statType: $0.statType,
                    statValue: $0.statValue
                )
            }
    }
}
