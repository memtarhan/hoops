//
//  NBAScoreView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct NBAScoreBottomFooter: Identifiable {
    let statType: String
    let playerName: String
    let statValue: String

    var id: String { statType + playerName + statValue }

    static let sample = [
        NBAScoreBottomFooter(statType: "PTS", playerName: "E. Mobley-CLE", statValue: "34"),
        NBAScoreBottomFooter(statType: "TRB", playerName: "D. Lively-DAL", statValue: "11"),
    ]
}

struct NBAPeriodScore: Identifiable {
    let period: String
    let awayTeamScore: Int
    let homeTeamScore: Int

    var id: String { period }
}

struct NBAScoreDisplayModel: Identifiable {
    let upperHeader: ScoreModel
    let periods: [NBAPeriodScore]
    let color: String
    let bottomFooter: [NBAScoreBottomFooter]

    var id: String { color }

    static let sample = NBAScoreDisplayModel(
        upperHeader: ScoreModel.sample[0],
        periods: [
            NBAPeriodScore(period: "1st", awayTeamScore: 20, homeTeamScore: 21),
            NBAPeriodScore(period: "2nd", awayTeamScore: 30, homeTeamScore: 32),
            NBAPeriodScore(period: "3rd", awayTeamScore: 22, homeTeamScore: 21),
            NBAPeriodScore(period: "4th", awayTeamScore: 20, homeTeamScore: 20),
        ],
        color: "#1D428A",
        bottomFooter: NBAScoreBottomFooter.sample
    )
}

struct NBAScoreView: View {
    var data: NBAScoreDisplayModel

    private let lighterColor = Color.white.opacity(0.7)

    var body: some View {
        VStack {
            upperHeader
            Divider()
            scoresSection
            Divider()
            bottomFooter
        }
        .padding()
//        .border(Color(hex: data.color), width: 1)
        .background(Color(hex: data.color))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    var upperHeader: some View {
        VStack {
            HStack {
                Text(data.upperHeader.firstTeam.teamName)
                    .font(.headline)
                Spacer()
                Text(data.upperHeader.firstTeam.score, format: .number)
                    .font(.title3.weight(.medium))
            }
            .foregroundStyle(data.upperHeader.firstTeam.isWinner ? lighterColor : Color.white)

            HStack {
                Text(data.upperHeader.secondTeam.teamName)
                    .font(.headline)
                Spacer()
                Text(data.upperHeader.secondTeam.score, format: .number)
                    .font(.title3.weight(.medium))
            }
            .foregroundStyle(data.upperHeader.secondTeam.isWinner ? Color.white : lighterColor)
        }
    }

    var scoresSection: some View {
        VStack {
            HStack {
                Spacer()
                ForEach(data.periods) { period in
                    Text(period.period)
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                        .padding(4)
                }
            }
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(data.upperHeader.firstTeam.teamName)
                    Text(data.upperHeader.secondTeam.teamName)
                }
                .font(.subheadline.italic())
                .foregroundStyle(Color.white)

                Spacer()
                HStack {
                    ForEach(data.periods) { period in
                        VStack {
                            Text(period.awayTeamScore, format: .number)
                                .font(.headline)
                                .foregroundStyle(period.awayTeamScore > period.homeTeamScore ? Color.white : lighterColor)
                            Text(period.homeTeamScore, format: .number)
                                .font(.headline)
                                .foregroundStyle(period.homeTeamScore > period.awayTeamScore ? Color.white : lighterColor)
                        }
                        .padding(4)
                    }
                }
            }
        }
    }
    
    var bottomFooter: some View {
        VStack {
            ForEach(data.bottomFooter) { row in
                HStack(alignment: .center) {
                    HStack(spacing: 32) {
                        Text(row.statType)
                            .font(.headline.weight(.light))
                        Text(row.playerName)
                            .font(.headline.weight(.medium))
                    }
                    Spacer()
                    Text(row.statValue)
                        .font(.headline.weight(.bold))
                }
                .foregroundStyle(Color.white)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    NBAScoreView(data: NBAScoreDisplayModel.sample)
}
