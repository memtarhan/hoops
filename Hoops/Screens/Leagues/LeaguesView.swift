//
//  LeaguesView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct LeagueTitleHeaderView: View {
    var title: String
    @Binding var isHidden: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .padding()

            Spacer()

            Button {
                isHidden.toggle()
            } label: {
                Image(systemName: isHidden ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                    .tint(.green)
            }
            .padding()
        }
        .frame(height: 45)
        .background(isHidden ? Color.clear : Color.gray.opacity(0.3))
    }
}

struct LeagueInfoHeaderView: View {
    var info: [String]

    var body: some View {
        HStack {
            ForEach(info, id: \.self) { infoPart in
                Text(infoPart)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: .infinity)
                Divider()
            }
        }
        .frame(height: 45)
        .background(Color.gray.opacity(0.1))
    }
}

struct StatsInfoHeaderView: View {
    var statsInfo: [[String]]

    var body: some View {
        HStack {
            ForEach(statsInfo, id: \.self) { statInfo in
                HStack {
                    ForEach(statInfo, id: \.self) { infoPart in
                        Text(infoPart)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .minimumScaleFactor(0.1)
                            .lineLimit(1)
                            .foregroundStyle(Color.red.opacity(0.8))
                            .frame(minWidth: 0, maxWidth: .infinity)
                        Divider()
                    }
                }
            }
        }

        .frame(height: 45)
        .background(Color.gray.opacity(0.1))
    }
}

struct LeagueStandingView: View {
    var standingInfo: LeagueTeamDisplayModel

    var body: some View {
        HStack(spacing: 0) {
            HStack {
                Text(standingInfo.seat)
                Text(standingInfo.teamName)
                Spacer()
            }
            .padding(.horizontal, 20)
            .font(.subheadline)
            .fontWeight(.semibold)
            .minimumScaleFactor(0.1)
//            .lineLimit(1)
            .frame(minWidth: 0, maxWidth: .infinity)

            Divider()
            HStack(spacing: 0) {
                ForEach(standingInfo.teamStats) { stat in
                    Text(stat.value)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.1)
                        .lineLimit(1)
                        .frame(minWidth: 0, maxWidth: .infinity)

                    Divider()
                }
            }
        }
        .frame(height: 45)
//        .background(Color.gray.opacity(0.1))
    }
}

struct LeagueStandingsView: View {
    var data: LeagueDisplayModel

    @State private var isHidden: Bool

    init(data: LeagueDisplayModel) {
        self.data = data
        isHidden = data.isHidden
    }

    var body: some View {
        VStack(spacing: 0) {
            LeagueTitleHeaderView(title: data.leagueTitle, isHidden: $isHidden)
            Divider()

            if isHidden {
                EmptyView()

            } else {
                LeagueInfoHeaderView(info: data.headerInfo)
                Divider()
                StatsInfoHeaderView(statsInfo: data.statsHeaderInfo)
                Divider()
                VStack(spacing: 0) {
                    ForEach(data.teams) { team in
                        LeagueStandingView(standingInfo: team)
                    }
                }
            }
        }
    }
}

struct LeaguesView: View {
    @StateObject var viewModel = LeaguesViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(viewModel.leagues) { league in
                        LeagueStandingsView(data: league)
                    }
                }
            }
            .navigationTitle("Leagues")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.fetchLeagues()
            }
        }
    }
}

#Preview {
    LeaguesView()
}
