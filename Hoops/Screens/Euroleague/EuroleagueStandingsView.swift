//
//  EuroleagueStandingsView.swift
//  Hoops
//
//  Created by Mehmet Tarhan on 6.01.2025.
//  Copyright © 2025 MEMTARHAN. All rights reserved.
//

import SwiftUI

struct StandingRow: View {
    var standing: StandingModel
    var width: CGFloat

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center) {
                HStack(alignment: .center, spacing: 8) {
                    Text(standing.seat)
                        .font(.footnote)
                        .padding(8)
                        .background(Color.green.opacity(0.2))
                        .clipShape(Circle())
                    Text(standing.name)
                        .font(.body.bold())
                        .frame(width: width)
                    Spacer()
                }
                Spacer()

                HStack(alignment: .center) {
                    ForEach(standing.stats) { stat in
                        VStack {
                            Text(stat.description)
                                .font(.caption)
                                .foregroundStyle(Color(hex: stat.color))
                            Text(stat.value)
                                .font(.subheadline)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .border(Color.green.opacity(0.2), width: 0.5)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
    }
}

struct EuroleagueStandingsView: View {
    var data: [StandingModel]

    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(data) { standing in
                    StandingRow(standing: standing, width: geometry.size.width / 2.5)
                }
            }
        }
    }
}

#Preview {
    EuroleagueStandingsView(data: [])
}
