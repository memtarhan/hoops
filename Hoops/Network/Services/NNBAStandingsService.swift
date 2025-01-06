//
//  NNBAStandingsService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol NNBAStandingsService: HTTPService, NBAEndpointsService {
    func getStandings() async throws -> NBAStandingsResponse
}

extension NNBAStandingsService {
    func getStandings() async throws -> NBAStandingsResponse {
        guard let endpoint = getStandingsURL() else {
            throw HTTPError.badURL
        }

        let response: NBAStandingsResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
