//
//  GameResultView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 28.02.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct GameResultTeam: Identifiable {
    let name: String
    let shortName: String
    let logo: String
    let score: Int
    let status: TeamStatus
    let periodScores: [Int]

    var id: String { name + shortName }

    static let sample = [GameResultTeam(name: "Oklahoma City Thunder",
                                        shortName: "OKC",
                                        logo: "https://res.cloudinary.com/hpve2bvgz/image/upload/f_auto,q_auto/v1/nba/teams/logos/oklahoma_city_thunder",
                                        score: 121,
                                        status: .winner,
                                        periodScores: [20, 30, 40, 31, 10]),
                         GameResultTeam(name: "Memphis Grizzlies",
                                        shortName: "MEM",
                                        logo: "https://res.cloudinary.com/hpve2bvgz/image/upload/f_auto,q_auto/v1/nba/teams/logos/memphis_grizzlies",
                                        score: 109,
                                        status: .loser,
                                        periodScores: [40, 30, 20, 19, 8])]
}

struct GameResultModel: Identifiable {
    let homeTeam: GameResultTeam
    let awayTeam: GameResultTeam
    let color: String

    var id: String { homeTeam.id + awayTeam.id }

    var periodsDescription: [String] {
        homeTeam.periodScores.enumerated().map { offset, _ in
            if offset > 4 {
                return "OT:\(offset - 4)"

            } else {
                return "Q\(offset + 1)"
            }
        }
    }

    static let sample = GameResultModel(homeTeam: GameResultTeam.sample[0],
                                        awayTeam: GameResultTeam.sample[1],
                                        color: "#890KLG")
}

struct LogoImageView: View {
    var logo: String
    var body: some View {
        AsyncImage(url: URL(string: logo)) { result in
            result.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct GameResultHomeTeamView: View {
    var data: GameResultTeam

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                LogoImageView(logo: data.logo)
                    .frame(width: 32)
                Text(data.shortName)
                    .font(.headline)
                    .foregroundStyle(data.status == .winner ? .primary : .secondary)
                Spacer()
                Text(data.score, format: .number)
                    .font(.largeTitle.weight(.medium))
                    .foregroundStyle(data.status == .winner ? .primary : .secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .foregroundStyle(.white)
    }
}

struct GameResultAwayTeamView: View {
    var data: GameResultTeam

    var body: some View {
        HStack(alignment: .center) {
            Text(data.score, format: .number)
                .font(.largeTitle.weight(.medium))
                .foregroundStyle(data.status == .winner ? .primary : .secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Spacer()
            Text(data.shortName)
                .font(.headline)
                .foregroundStyle(data.status == .winner ? .primary : .secondary)
            LogoImageView(logo: data.logo)
                .frame(width: 32)
        }
        .foregroundStyle(.white)
    }
}

struct GameResultOverviewView: View {
    var data: GameResultModel

    var body: some View {
        HStack(spacing: 20) {
            GameResultAwayTeamView(data: data.awayTeam)
                .frame(minWidth: 0, maxWidth: .infinity)

            Text("VS")
                .font(.caption2.weight(.bold))
                .foregroundStyle(.white)

            GameResultHomeTeamView(data: data.homeTeam)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
}

struct GameResultPeriodsView: View {
    var data: GameResultModel

    var body: some View {
        VStack {
            HStack {
                Spacer()

                Divider()
//                    .background(.white)

                ForEach(data.periodsDescription, id: \.self) { description in
                    HStack {
                        Text(description)
                            .frame(width: 36)

                        Divider()
                            .background(.white)
                    }
                }
            }

            Divider()

            HStack {
                LogoImageView(logo: data.awayTeam.logo)
                    .frame(width: 32)
                Spacer()

                Divider()
//                    .background(.white)

                ForEach(data.awayTeam.periodScores, id: \.self) { score in
                    HStack {
                        Text(score, format: .number)
                            .frame(width: 36)

                        Divider()
                            .background(.white)
                    }
                }
            }

            Divider()

            HStack {
                LogoImageView(logo: data.homeTeam.logo)
                    .frame(width: 32)
                Spacer()

                Divider()
//                    .background(.white)

                ForEach(data.homeTeam.periodScores, id: \.self) { score in
                    HStack {
                        Text(score, format: .number)
                            .frame(width: 36)

                        Divider()
                            .background(.white)
                    }
                }
            }
        }
        .foregroundStyle(.white)
    }
}

struct GameResultView: View {
    var data: GameResultModel

    var body: some View {
        VStack {
            GameResultOverviewView(data: data)

            GameResultPeriodsView(data: data)
                .frame(height: 120)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(hex: data.color))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .circular))
    }
}

#Preview {
    GameResultView(data: GameResultModel.sample)
        .padding()
}
