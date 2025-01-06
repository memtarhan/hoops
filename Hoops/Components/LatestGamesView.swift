//
//  LatestGamesView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct LatestGameRow: View {
    var data: ScoreModel
    var body: some View {
        VStack {
            HStack {
                Text(data.firstTeam.teamName)
                    .font(.headline.weight(data.firstTeam.isWinner ? .light : .medium))
                Spacer()
                Text(data.firstTeam.score, format: .number)
                    .font(.title3.weight(data.secondTeam.isWinner ? .light : .medium))

            }
            
            HStack {
                Text(data.secondTeam.teamName)
                    .font(.headline.weight(data.secondTeam.isWinner ? .medium : .light))

                Spacer()
                Text(data.secondTeam.score, format: .number)
                    .font(.title3.weight(data.secondTeam.isWinner ? .medium : .light))

            }
        }
    }
}

struct LatestGamesView: View {
    var data: [ScoreModel]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(data) { game in
                    LatestGameRow(data: game)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 32)
                        .background(Color.systemBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.leading, 20)


                }
            }
        }
    }
}

#Preview {
    LatestGamesView(data: ScoreModel.sample)
        .background(Color.primary.quaternary.opacity(0.3))
        .frame(height: 400)
}
