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
    @Published var loading: Bool = true
    @Published var latestGames: [ScoreModel] = []
    @Published var topPerformers: [TopPerformerModel] = []
    @Published var statLeaders: [StatLeaderModel] = []


    func fetchLatest() async {
        async let games = getLatestScores()
        async let performers = getTopPerformers()
        async let leaders = getStatLeaders()

        let response = try! await [games, performers, leaders]

        handleLatestGames(response: response[0] as! LatestScoresResponse)
        handleTopPerformers(response: response[1] as! TopPerformersResponse)
        handleStatLeaders(response: response[2] as! StatLeadersResponse)
        
        loading = false
    }

    private func handleLatestGames(response: LatestScoresResponse) {
        let scoreModels = response.latestScores.map { scoreResponse in
            let firstTeam = TeamScoreModel(
                teamName: scoreResponse[0].teamName,
                score: scoreResponse[0].teamScore,
                isWinner: scoreResponse[0].teamStatus == .winner
            )

            let secondTeam = TeamScoreModel(
                teamName: scoreResponse[1].teamName,
                score: scoreResponse[1].teamScore,
                isWinner: scoreResponse[1].teamStatus == .winner
            )

            return ScoreModel(firstTeam: firstTeam, secondTeam: secondTeam)
        }

        latestGames = scoreModels
    }

    private func handleTopPerformers(response: TopPerformersResponse) {
        topPerformers = response.performers
            .map { TopPerformerModel(
                playerName: $0.playerName,
                points: $0.rebounds,
                rebounds: $0.rebounds,
                assists: $0.assists
            )
            }
    }

    private func handleStatLeaders(response: StatLeadersResponse) {
        statLeaders = response.statLeaders
            .map {
                StatLeaderModel(
                    playerName: $0.playerName,
                    statType: $0.statType,
                    statValue: $0.statValue
                )
            }
    }
}
