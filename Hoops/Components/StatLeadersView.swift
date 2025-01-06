//
//  StatLeadersView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct StatLeaderModel: Identifiable {
    let playerName: String
    let statType: String
    let statValue: Double

    var id: String { statType + playerName }

    static let sample = [
        StatLeaderModel(playerName: "Giannis Antetokounmpo", statType: "PPG Leader", statValue: 32.6),
        StatLeaderModel(playerName: "Domantas Sabonis", statType: "RPG Leader", statValue: 13.6),
        StatLeaderModel(playerName: "Trae Young", statType: "APG Leader", statValue: 12.2),
        StatLeaderModel(playerName: "Shai Gilgeous-Alexander", statType: "WS Leader", statValue: 7),
    ]
}

struct StatLeaderRow: View {
    let data: StatLeaderModel
    let width: CGFloat

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack {
                Text(data.statType)
                    .font(.subheadline.weight(.medium))
                    .multilineTextAlignment(.leading)
                    .frame(width: width)

                Text(data.playerName)
                    .font(.headline.weight(.thin))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
            }
            Spacer()
            Text(data.statValue, format: .number)
                .font(.headline)
        }
    }
}

struct StatLeadersView: View {
    var data: [StatLeaderModel]
    var body: some View {
        VStack {
            ForEach(data) { statLeader in
                StatLeaderRow(data: statLeader, width: 96)
                    .padding(4)
            }
        }
    }
}

#Preview {
    StatLeadersView(data: StatLeaderModel.sample)
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .background(Color.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
}
