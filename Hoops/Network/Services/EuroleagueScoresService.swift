//
//  EuroleagueScoresService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol EuroleagueScoresService: HTTPService, EuroleagueEndpointsService {
    func getScores() async throws -> EuroleagueScoresResponse
}

extension EuroleagueScoresService {
    func getScores() async throws -> EuroleagueScoresResponse {
        guard let endpoint = getScoresURL() else {
            throw HTTPError.badURL
        }

        let response: EuroleagueScoresResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
