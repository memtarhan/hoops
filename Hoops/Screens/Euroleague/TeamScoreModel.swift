//
//  TeamScoreModel.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

struct ScoreModel: Identifiable {
    let firstTeam: TeamScoreModel
    let secondTeam: TeamScoreModel

    var id: String { firstTeam.teamName }

    static let sample = [ScoreModel(firstTeam: TeamScoreModel(teamName: "ABC", score: 120, isWinner: true),
                                    secondTeam: TeamScoreModel(teamName: "BNC", score: 90, isWinner: false)),
                         ScoreModel(firstTeam: TeamScoreModel(teamName: "XCV", score: 50, isWinner: false),
                                    secondTeam: TeamScoreModel(teamName: "KLO", score: 60, isWinner: true))]
}

struct TeamScoreModel: Identifiable {
    let teamName: String
    let score: Int
    let isWinner: Bool

    var id: String { teamName }
}


struct StatModel: Identifiable {
    let description: String
    let value: String
    let color: String

    var id: String {
        description
    }
}

struct StandingModel: Identifiable {
    let name: String
    let seat: String
    let stats: [StatModel]

    var id: String {
        name
    }
}
