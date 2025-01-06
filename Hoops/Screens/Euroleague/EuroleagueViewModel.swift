//
//  EuroleagueViewModel.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class EuroleagueViewModel: ObservableObject, EuroleagueScoresService, EuroleagueStandingsService {
    @Published var loading: Bool = true
    @Published var scores: [ScoreModel] = []
    @Published var standings: [StandingModel] = []

    func handleData() async {
        async let scores = getScores()
        async let standings = getStandings()

        let response = try! await [scores, standings]

        handleScores(response: response[0] as! EuroleagueScoresResponse)
        handleStandings(response: response[1] as! StandingsResponse)
        
        loading = false
    }

    private func handleScores(response: EuroleagueScoresResponse) {
        let scoreModels = response.scores.map { scoreResponse in
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

        scores = scoreModels
    }

    private func handleStandings(response: StandingsResponse) {
        let standingModels = response.standings.enumerated().map { index, standing in
            StandingModel(name: standing.teamName,
                          seat: "\(index + 1)",
                          stats: standing.stats.map { stat in
                              StatModel(description: stat.shortName,
                                        value: stat.value,
                                        color: stat.color)
                          })
        }

        standings = standingModels
    }
}
