//
//  habit.swift
//  habit-tracking
//
//  Created by Yuki Shinohara on 2020/04/05.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable{
    let id = UUID()
    let name: String
    var amount: Int
    let detail: String
}

class Habits: ObservableObject {
    @Published var array: [Habit] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(array) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    init() {
        if let habits = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: habits) {
                self.array = decoded
                return
            }
        }
        self.array = []
    }
}
