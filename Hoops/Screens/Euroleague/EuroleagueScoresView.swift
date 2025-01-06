//
//  EuroleagueScoresView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct ScoreRow: View {
    var score: TeamScoreModel

    var body: some View {
        HStack(alignment: .center) {
            Text("\(score.teamName)")
                .font(score.isWinner ? .body.bold() : .body)
            Spacer()
            HStack {
                Text("\(score.score)")
                    .font(score.isWinner ? .body.bold() : .body)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
        }
    }
}

struct EuroleagueScoresView: View {
    var data: [ScoreModel]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(data) { score in
                    VStack(alignment: .leading) {
                        ScoreRow(score: score.firstTeam)
                        ScoreRow(score: score.secondTeam)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.systemBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
    }
}

#Preview {
    EuroleagueScoresView(data: ScoreModel.sample)
        .background(Color.secondarySystemBackground)
}
