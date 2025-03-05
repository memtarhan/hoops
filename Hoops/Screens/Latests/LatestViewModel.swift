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
    @Published var latestGames: [GameResultModel] = []
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
