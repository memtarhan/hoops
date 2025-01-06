//
//  LeaguesService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol LeaguesService: HTTPService, LeaguesEndpointsService {
    func getStandings() async throws -> LeaguesResponse
}

extension LeaguesService {
    func getStandings() async throws -> LeaguesResponse {
        guard let endpoint = getStandingsURL() else {
            throw HTTPError.badURL
        }

        let response: LeaguesResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
