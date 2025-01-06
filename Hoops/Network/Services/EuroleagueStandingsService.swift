//
//  EuroleagueStandingsService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol EuroleagueStandingsService: HTTPService, EuroleagueEndpointsService {
    func getStandings() async throws -> StandingsResponse
}

extension EuroleagueStandingsService {
    func getStandings() async throws -> StandingsResponse {
        guard let endpoint = getStandingsURL() else {
            throw HTTPError.badURL
        }

        let response: StandingsResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
