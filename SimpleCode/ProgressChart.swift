//
//  ProgressChartView.swift
//  SimpleCode
//
//  Created by ShuZik on 02.06.2024.
//

import SwiftUI
import Charts

struct ProgressChartView: View {
    let portions: [ProgressChartModel]
    let day: Int
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            if let rollout = portions.first(where: { $0.day == day })?.percentage {
                ZStack(alignment: .center) {
                    VStack {
                        Text("\(Int(rollout))%")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }
                    
                    Chart(portions, id: \.day) { element in
                        SectorMark(
                            angle: .value("Phased Release Progress", element.portion),
                            innerRadius: .ratio(0.55),
                            angularInset: 2
                        )
                        .cornerRadius(10)
                        .foregroundStyle(day >= element.day ? Color("MyColor") : Color("MyColor").opacity(0.3))
                    }
                }
                .frame(width: 250, height: 250)
            }
        }
    }
}

#Preview {
    ProgressChartView(portions: ProgressChartModel.mock ,day: 5)
}

// MARK: Model
struct ProgressChartModel {
    let day: Int
    let portion: Double
    let percentage: Int
}

extension ProgressChartModel {
    static let mock = [
        ProgressChartModel(day: 1, portion: 0.1, percentage: 1),
        ProgressChartModel(day: 2, portion: 0.1, percentage: 2),
        ProgressChartModel(day: 3, portion: 0.3, percentage: 5),
        ProgressChartModel(day: 4, portion: 0.5, percentage: 10),
        ProgressChartModel(day: 5, portion: 0.1, percentage: 20),
        ProgressChartModel(day: 6, portion: 0.3, percentage: 50),
        ProgressChartModel(day: 7, portion: 0.5, percentage: 100)
    ]
}
