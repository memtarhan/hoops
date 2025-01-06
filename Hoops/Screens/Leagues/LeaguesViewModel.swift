//
//  LeaguesViewModel.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

struct LeagueTeamStatsDisplayModel: Identifiable {
    let name: String
    let value: String

    var id: String { name }

    static let sample = [LeagueTeamStatsDisplayModel(name: "W", value: "1"),
                         LeagueTeamStatsDisplayModel(name: "L", value: "1"),
                         LeagueTeamStatsDisplayModel(name: "W/L%", value: "0.5"),
                         LeagueTeamStatsDisplayModel(name: "GB", value: "2")]
}

struct LeagueTeamDisplayModel: Identifiable {
    let seat: String
    let teamName: String
    let teamStats: [LeagueTeamStatsDisplayModel]

    var id: String { teamName }

    static let sample = [LeagueTeamDisplayModel(
        seat: "1",
        teamName: "Barcelona",
        teamStats: LeagueTeamStatsDisplayModel.sample
    )]
}

struct LeagueDisplayModel: Identifiable {
    let leagueTitle: String
    let headerInfo: [String]
    let statsHeaderInfo: [[String]]
    let teams: [LeagueTeamDisplayModel]
    var isHidden: Bool = false

    var id: String { leagueTitle }

    static let sample = LeagueDisplayModel(
        leagueTitle: "Liga Endesa",
        headerInfo: [
            "",
            "Regular Season",
        ],
        statsHeaderInfo: [
            ["Team"],
            [
                "W",
                "L",
                "W/L%",
                "GB",
            ],
        ], teams: LeagueTeamDisplayModel.sample
    )
}

@MainActor
class LeaguesViewModel: ObservableObject, LeaguesService {
    @Published var leagues: [LeagueDisplayModel] = []

    func fetchLeagues() async {
        let response = try! await getStandings().leagues

        leagues = response.enumerated().map { leagueIndex, league in
            LeagueDisplayModel(leagueTitle: league.title,
                               headerInfo: league.header,
                               statsHeaderInfo: league.statsHeader,
                               teams: league.standings.enumerated().map { index, team in
                                   LeagueTeamDisplayModel(seat: "\(index + 1)",
                                                          teamName: team.teamName,
                                                          teamStats: team.stats.map { stat in
                                                              LeagueTeamStatsDisplayModel(name: stat.shortName,
                                                                                          value: stat.value)
                                                          })

                               },
                               isHidden: leagueIndex != 0)
        }
    }
}
