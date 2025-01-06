//
//  NBAScoresService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol NBAScoresService: HTTPService, NBAEndpointsService {
    func getScores(date: Date?) async throws -> ScoresResponseX
}

extension NBAScoresService {
    func getScores(date: Date? = nil) async throws -> ScoresResponseX {
        guard let endpoint = getScoresURL(date: date) else {
            throw HTTPError.badURL
        }

        let response: ScoresResponseX = try await handleDataTask(from: endpoint)
        return response
    }
}
