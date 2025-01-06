//
//  TopPerformersView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct TopPerformerModel: Identifiable {
    let playerName: String
    let points: Int
    let rebounds: Int
    let assists: Int

    var id: String { playerName + "\(points)\(rebounds)\(assists)" }

    static let sample = [
        TopPerformerModel(playerName: "Nikola Jokić(DEN)", points: 33, rebounds: 12, assists: 12),
        TopPerformerModel(playerName: "Karl-Anthony Towns(NYK)", points: 24, rebounds: 20, assists: 10),
    ]
}

struct TopPerformerHeader: View {
    var headers: [String]

    var body: some View {
        HStack {
            ForEach(headers, id: \.self) { header in
                Text(header)
//                    .frame(minWidth: 0, maxWidth: .infinity)
            }
        }
    }
}

struct TopPerformerRow: View {
    var data: TopPerformerModel

    var body: some View {
        HStack {
            Text(data.playerName)
            Spacer()
            HStack {
                Text("\(data.points)")
                Text("\(data.rebounds)")
                Text("\(data.assists)")
            }
        }
    }
}

struct TopPerformersStatsColumns: View {
    var data: [TopPerformerModel]
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            VStack(alignment: .leading) {
                Text("")
                    .padding(4)
                ForEach(data) { statData in
                    Text(statData.playerName)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(.subheadline.weight(.medium))
                }
            }
            .padding()

            Spacer()

            HStack {
                // Points
                VStack {
                    Text("PTS")
                        .font(.subheadline)
                        .padding(4)
                    ForEach(data) { statData in
                        Text(statData.points, format: .number)
                    }
                }

                Divider()

                // Rebounds
                VStack {
                    Text("TRB")
                        .font(.subheadline)
                        .padding(4)
                    ForEach(data) { statData in
                        Text(statData.rebounds, format: .number)
                    }
                }

                Divider()

                // Assists
                VStack {
                    Text("AST")
                        .font(.subheadline)
                        .padding(4)
                    ForEach(data) { statData in
                        Text(statData.assists, format: .number)
                    }
                }
            }
            .padding(4)
        }
    }
}

struct TopPerformersView: View {
    var data: [TopPerformerModel]

    var body: some View {
        VStack {
            TopPerformersStatsColumns(data: data)
        }
    }
}

#Preview {
    TopPerformersView(data: TopPerformerModel.sample)
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
        .background(Color.secondary.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
        .frame(height: 200)
}
