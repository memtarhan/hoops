//
//  StandingsHeaderView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct TeamStatsModel: Identifiable {
    let name: String
    let value: String

    var id: String { name + value }
}

struct TeamStandingModel: Identifiable {
    let seat: String
    let name: String
    let shortName: String
    let logo: String

    let stats: [TeamStatsModel]

    var id: String { shortName + seat + name }

    static let sample = [
        TeamStandingModel(seat: "1",
                          name: "Houston 1",
                          shortName: "HOU",
                          logo: "https://content.sportslogos.net/logos/6/230/full/6830_houston_rockets-primary-2020.png",
                          stats: [TeamStatsModel(name: "W", value: "18"),
                                  TeamStatsModel(name: "L", value: "9"),
                                  TeamStatsModel(name: "PCT", value: "0.898"),
                                  TeamStatsModel(name: "GB", value: "5"),
                                  TeamStatsModel(name: "PS/G", value: "120"),
                                  TeamStatsModel(name: "PA/G", value: "104"),
                                  TeamStatsModel(name: "SRS", value: "34")]),
        TeamStandingModel(seat: "2",
                          name: "Houston 2",
                          shortName: "HOU2",
                          logo: "https://content.sportslogos.net/logos/6/230/full/6830_houston_rockets-primary-2020.png",
                          stats: [TeamStatsModel(name: "W", value: "18"),
                                  TeamStatsModel(name: "L", value: "9"),
                                  TeamStatsModel(name: "PCT", value: "0.898"),
                                  TeamStatsModel(name: "GB", value: "5"),
                                  TeamStatsModel(name: "PS/G", value: "120"),
                                  TeamStatsModel(name: "PA/G", value: "104"),
                                  TeamStatsModel(name: "SRS", value: "34")]),
        TeamStandingModel(seat: "3",
                          name: "Houston 3",
                          shortName: "HOU3",
                          logo: "https://content.sportslogos.net/logos/6/230/full/6830_houston_rockets-primary-2020.png",
                          stats: [TeamStatsModel(name: "W", value: "18"),
                                  TeamStatsModel(name: "L", value: "9"),
                                  TeamStatsModel(name: "PCT", value: "0.898"),
                                  TeamStatsModel(name: "GB", value: "5"),
                                  TeamStatsModel(name: "PS/G", value: "120"),
                                  TeamStatsModel(name: "PA/G", value: "104"),
                                  TeamStatsModel(name: "SRS", value: "34")]),
    ]
}

struct StandingsHeaderModel {
    let name: String

    static let sample = [StandingsHeaderModel(name: "W"),
                         StandingsHeaderModel(name: "L"),
                         StandingsHeaderModel(name: "PCT"),
                         StandingsHeaderModel(name: "GB"),
                         StandingsHeaderModel(name: "PS/G"),
                         StandingsHeaderModel(name: "PA/G"),
                         StandingsHeaderModel(name: "SRS")]
}

struct StandingsHeaderData {
    let title: String
    let data: [StandingsHeaderModel]

    static let sample = StandingsHeaderData(title: "WEST", data: StandingsHeaderModel.sample)
}

struct StatsHeaderView: View {
    var title: String
    var seat: String?
    var logo: String?
    var color: Color = .clear
    var itemWidth: CGFloat = 160

    var body: some View {
        HStack(spacing: 12) {
            if let seat {
                Text(seat)
            }
            if let logo {
                AsyncImage(url: URL(string: logo)) { result in
                    result.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 36, height: 36, alignment: .center)
                }
            }
            Text(title)
        }
        .font(.subheadline.weight(.semibold))
        .padding(.vertical, 12)
        .frame(width: itemWidth)
        .background(color)
    }
}

struct StatRowData: Identifiable {
    let id = UUID()

    let value: String
}

struct StatsRowView: View {
    var data: [StatRowData]
    var color: Color = .clear
    var itemWidth: CGFloat = 45

    // TODO: Some stats can have the same value and that affects list performance, have a key-value structure maybe?
    var body: some View {
        HStack(spacing: 0) {
            ForEach(data) { item in
                Text(item.value)
                    .font(.subheadline.weight(.medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.vertical, 12)
                    .frame(minWidth: itemWidth)
            }
        }
        .background(color)
    }
}

struct StandingsHeaderView: View {
    let headerData: StandingsHeaderData
    let standings: [TeamStandingModel]

    var body: some View {
        ScrollView {
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    StatsHeaderView(title: headerData.title, color: Color.gray.opacity(0.2))
                        .frame(height: 45)

                    ForEach(standings) { teamStanding in
                        StatsHeaderView(title: teamStanding.shortName, seat: teamStanding.seat, logo: teamStanding.logo)
                            .frame(height: 45)
                    }
                }

                Divider()
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack(spacing: 0) {
                        StatsRowView(data: headerData.data.map { StatRowData(value: $0.name) }, color: Color.gray.opacity(0.2))
                            .frame(height: 45)

                        ForEach(standings) { standing in
                            StatsRowView(data: standing.stats.map { StatRowData(value: $0.value) })
                                .frame(height: 45)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    StandingsHeaderView(headerData: StandingsHeaderData.sample,
                        standings: TeamStandingModel.sample)
}
