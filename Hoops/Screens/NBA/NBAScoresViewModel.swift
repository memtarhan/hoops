//
//  NBAScoresViewModel.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class NBAScoresViewModel: ObservableObject, NBAScoresService {
    @Published var data: [NBAScoreDisplayModel] = []
    @Published var title: String = "..."
    @Published var description: String? = nil

    private var currentDisplayedDate: Date?

    func updateWithPreviousDate() {
        if let currentDisplayedDate {
            self.currentDisplayedDate = currentDisplayedDate.addingTimeInterval(-1 * 60 * 60 * 24)

        } else {
            currentDisplayedDate = Date()
        }

        refresh()
    }

    func updateWithNextDate() {
        if let currentDisplayedDate {
            self.currentDisplayedDate = currentDisplayedDate.addingTimeInterval(1 * 60 * 60 * 24)

        } else {
            currentDisplayedDate = Date()
        }

        refresh()
    }

    private func refresh() {
        data.removeAll()
        title = "..."

        Task {
            await fetchScores()
        }
    }

    func refreshToDate() {
        data.removeAll()
        title = "..."
        currentDisplayedDate = nil

        Task {
            await fetchScores()
        }
    }

    func fetchScores() async {
        let response = try! await getScores(date: currentDisplayedDate)
        let date = response.date
        currentDisplayedDate = date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        title = formatter.string(from: date)
        data = response.scores
            .map { score in
                let firstTeam = TeamScoreModel(teamName: score.awayTeam.teamName, score: score.awayTeam.teamScore, isWinner: score.awayTeam.teamStatus == .winner)
                let secondTeam = TeamScoreModel(teamName: score.homeTeam.teamName, score: score.homeTeam.teamScore, isWinner: score.homeTeam.teamStatus == .winner)

                return NBAScoreDisplayModel(
                    upperHeader: ScoreModel(firstTeam: firstTeam, secondTeam: secondTeam),
                    periods: self.getPeriodStatsData([score.awayTeam, score.homeTeam].map { $0.periodScores }),
                    color: score.color,
                    bottomFooter: (score.stats ?? []).map { stat in
                        NBAScoreBottomFooter(statType: stat[0], playerName: stat[1], statValue: stat[2])
                    }
                )
            }

        if data.isEmpty {
            description = "No games played on this date.\nPull to get the latest scores"

        } else {
            description = nil
        }
    }

    func getPeriodName(forPeriodIndex index: Int) -> String {
        switch index {
        case 0: return "1st"
        case 1: return "2nd"
        case 2: return "3rd"
        case 3: return "4th"
        case 4...: return "OT\(index + 1)"
        default: return ""
        }
    }

    func getPeriodStatsData(_ data: [[Int]]) -> [NBAPeriodScore] {
        guard let away = data.first,
              let home = data.last else { return [] }

        var data = [NBAPeriodScore]()

        var index = 0
        for (away, home) in zip(away, home) {
            data.append(NBAPeriodScore(period: getPeriodName(forPeriodIndex: index),
                                       awayTeamScore: away,
                                       homeTeamScore: home))
            index += 1
        }

        return data
    }
}
