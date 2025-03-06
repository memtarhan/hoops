//
//  EndpointsService.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

private let baseURL = "https://hoops.koyeb.app"
//private let baseURL = "http://127.0.0.1:8000"

protocol EndpointsService { }

protocol NBAEndpointsService: EndpointsService {
    func getScoresURL(date: Date?) -> URL?
    func getStandingsURL() -> URL?
    func getLatestURL() -> URL?
    func getLatestScoresURL() -> URL?
    func getLatestTopPerformersURL() -> URL?
    func getStatLeadersURL() -> URL?
}

extension NBAEndpointsService {
    func getScoresURL(date: Date?) -> URL? {
        var url: URL?
        if let date {
            let calendar = Calendar.current
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let year = calendar.component(.year, from: date)

            url = URL(string: "\(baseURL)/nba/scores?month=\(month)&day=\(day)&year=\(year)")

        } else {
            url = URL(string: "\(baseURL)/nba/scores")
        }

        return url
    }

    func getStandingsURL() -> URL? {
        URL(string: "\(baseURL)/nba/standings")
    }

    func getLatestURL() -> URL? {
        URL(string: "\(baseURL)/nba/latest")
    }
    
    func getLatestScoresURL() -> URL? {
        URL(string: "\(baseURL)/nba/latest-scores")
    }

    func getLatestTopPerformersURL() -> URL? {
        URL(string: "\(baseURL)/nba/latest-top-performers")
    }

    func getStatLeadersURL() -> URL? {
        URL(string: "\(baseURL)/nba/stat-leaders")
    }
}

protocol EuroleagueEndpointsService: EndpointsService {
    func getScoresURL() -> URL?
    func getStandingsURL() -> URL?
}

extension EuroleagueEndpointsService {
    func getScoresURL() -> URL? {
        URL(string: "\(baseURL)/euroleague/scores")
    }

    func getStandingsURL() -> URL? {
        URL(string: "\(baseURL)/euroleague/standings")
    }
}

protocol LeaguesEndpointsService: EndpointsService {
    func getStandingsURL() -> URL?
}

extension LeaguesEndpointsService {
    func getStandingsURL() -> URL? {
        URL(string: "\(baseURL)/leagues/standings")
    }
}
