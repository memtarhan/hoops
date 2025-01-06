//
//  NBAStandingsViewModel.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

@MainActor
class NBAStandingsViewModel: ObservableObject, NNBAStandingsService {
    @Published var data: [(StandingsHeaderData, [TeamStandingModel])?] = []

    func fetchStandings() async {
        let response = try! await getStandings()

        let eastHeader = StandingsHeaderData(title: "EAST", data: StandingsHeaderModel.sample)
        let eastStandingstandings = response.standings.east.enumerated().map { index, standing in
            TeamStandingModel(seat: "\(index + 1)",
                              name: standing.teamName,
                              shortName: standing.teamShortName,
                              logo: standing.teamLogo,
                              stats: standing.stats.map {
                                  TeamStatsModel(name: $0.shortName.rawValue, value: $0.value)
                              })
        }

        let westHeader = StandingsHeaderData(title: "WEST", data: StandingsHeaderModel.sample)
        let westStandingstandings = response.standings.west.enumerated().map { index, standing in
            TeamStandingModel(seat: "\(index + 1)",
                              name: standing.teamName,
                              shortName: standing.teamShortName,
                              logo: standing.teamLogo,
                              stats: standing.stats.map {
                                  TeamStatsModel(name: $0.shortName.rawValue, value: $0.value)
                              })
        }

        data = [(eastHeader, eastStandingstandings), (westHeader, westStandingstandings)]
    }
}
