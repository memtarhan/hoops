//
//  LatestService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol LatestService: HTTPService, NBAEndpointsService {
    func getLatestScores() async throws -> LatestScoresResponse
    func getTopPerformers() async throws -> TopPerformersResponse
    func getStatLeaders() async throws -> StatLeadersResponse
}

extension LatestService {
    func getLatestScores() async throws -> LatestScoresResponse {
        guard let endpoint = getLatestScoresURL() else {
            throw HTTPError.badURL
        }

        let response: LatestScoresResponse = try await handleDataTask(from: endpoint)
        return response
    }

    func getTopPerformers() async throws -> TopPerformersResponse {
        guard let endpoint = getLatestTopPerformersURL() else {
            throw HTTPError.badURL
        }

        let response: TopPerformersResponse = try await handleDataTask(from: endpoint)
        return response
    }

    func getStatLeaders() async throws -> StatLeadersResponse {
        guard let endpoint = getStatLeadersURL() else {
            throw HTTPError.badURL
        }

        let response: StatLeadersResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
