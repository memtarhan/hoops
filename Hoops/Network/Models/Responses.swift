//
//  Responses.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import Foundation

protocol HTTPResponse: Decodable { }

// MARK: - LeaguesResponse

struct LeaguesResponse: HTTPResponse {
    let leagues: [LeagueResponse]
}

// MARK: - LeagueResponse

struct LeagueResponse: HTTPResponse {
    let title: String
    let header: [String]
    let statsHeader: [[String]]
    let standings: [StandingsResponseX]

    enum CodingKeys: String, CodingKey {
        case statsHeader = "stats_header"
        case title, header, standings
    }
}

// MARK: - StandingsResponseX

struct StandingsResponseX: HTTPResponse {
    let teamName: String
    let stats: [StatResponse]

    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
        case stats
    }
}

// MARK: - StatResponse

struct StatResponse: HTTPResponse {
    let name: String
    let value: String
    let shortName: String

    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case name, value
    }
}

// MARK: - StandingsResponse

struct StandingsResponse: HTTPResponse {
    let standings: [Standing]
}

// MARK: - Standing

struct Standing: HTTPResponse {
    let teamName: String
    let stats: [Stat]

    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
        case stats
    }
}

// MARK: - Stat

// MARK: - Stat

struct Stat: HTTPResponse {
    let name: String
    let value: String
    let shortName: String
    let color: String

    enum CodingKeys: String, CodingKey {
        case name, value
        case shortName = "short_name"
        case color
    }
}

// MARK: - ScoresResponse

struct EuroleagueScoresResponse: HTTPResponse {
    let title: String
    let scores: [[ScoreResponse]]
}

// MARK: - Welcome

struct NBAStandingsResponse: HTTPResponse {
    let standings: NBAStandings
}

// MARK: - Standings

struct NBAStandings: HTTPResponse {
    let west, east: [NBAEast]
}

// MARK: - East

struct NBAEast: HTTPResponse {
    let teamName, teamShortName: String
    let teamLogo: String
    let stats: [NBAStat]

    enum CodingKeys: String, CodingKey {
        case teamName = "team_name"
        case teamShortName = "team_short_name"
        case teamLogo = "team_logo"
        case stats
    }
}

// MARK: - Stat

struct NBAStat: HTTPResponse {
    let name: StatName
    let value: String
    let shortName: StatShortName

    enum CodingKeys: String, CodingKey {
        case name, value
        case shortName = "short_name"
    }
}

enum StatName: String, HTTPResponse {
    case gb
    case losses
    case oppPtsPerG = "opp_pts_per_g"
    case ptsPerG = "pts_per_g"
    case srs
    case winLossPct = "win_loss_pct"
    case wins
}

enum StatShortName: String, HTTPResponse {
    case gb = "GB"
    case l = "L"
    case paG = "PA/G"
    case psG = "PS/G"
    case srs = "SRS"
    case w = "W"
    case wL = "W/L%"
}

// MARK: - ScoresResponseX

struct ScoresResponseX: HTTPResponse {
    let date: Date
    let scores: [GameScoresResponse]
}

// MARK: - GameScoresResponse

struct GameScoresResponse: HTTPResponse {
    let homeTeam: ScoreResponse
    let awayTeam: ScoreResponse
    let stats: [[String]]?
    let color: String

    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case stats
        case color
    }
}

// MARK: - ScoreResponse

struct ScoreResponse: HTTPResponse {
    let periodScores: [Int]
    let teamLogo: String
    let teamShortName: String
    let teamName: String
    let teamScore: Int
    let teamStatus: TeamStatus

    enum CodingKeys: String, CodingKey {
        case periodScores = "period_scores"
        case teamLogo = "team_logo"
        case teamShortName = "team_short_name"
        case teamName = "team_name"
        case teamScore = "team_score"
        case teamStatus = "team_status"
    }
}

enum TeamStatus: String, Codable {
    case loser
    case winner
}

// MARK: - LatestScoresResponse

struct LatestScoresResponse: HTTPResponse {
    let latestScores: [GameScoresResponse]

    enum CodingKeys: String, CodingKey {
        case latestScores = "latest_scores"
    }
}

// MARK: - TopPerformerResponse

struct TopPerformerResponse: HTTPResponse {
    let playerName: String
    let points: Int
    let rebounds: Int
    let assists: Int

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case points = "pts"
        case rebounds = "trb"
        case assists = "ast"
    }
}

// MARK: - TopPerformersResponse

struct TopPerformersResponse: HTTPResponse {
    let performers: [TopPerformerResponse]
}

// MARK: - StatLeaderResponse

struct StatLeaderResponse: HTTPResponse {
    let playerName: String
    let statType: String
    let statValue: Double

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case statType = "stat_type"
        case statValue = "stat_value"
    }
}

// MARK: - StatLeadersResponse

struct StatLeadersResponse: HTTPResponse {
    let statLeaders: [StatLeaderResponse]

    enum CodingKeys: String, CodingKey {
        case statLeaders = "stat_leaders"
    }
}
