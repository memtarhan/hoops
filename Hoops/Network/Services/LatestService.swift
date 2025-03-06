//
//  LatestService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol LatestService: HTTPService, NBAEndpointsService {
    func getLatest() async throws -> LatestResponse
}

extension LatestService {
    func getLatest() async throws -> LatestResponse {
        guard let endpoint = getLatestURL() else {
            throw HTTPError.badURL
        }

        let response: LatestResponse = try await handleDataTask(from: endpoint)
        return response
    }
}
