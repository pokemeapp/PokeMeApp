//
//  MockHabitGenerator.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation

class MockHabitGenerator {
    
    var mockHabitDatabase: MockHabitDatabase?
    
    func createMockHabits(_ count: Int) -> [MockHabit] {
        self.mockHabitDatabase = MockHabitDatabase()
        let mockUserGenerator = MockUserGenerator(options: [.firstName, .lastName, .fullName])
        let mockUsers = mockUserGenerator.createMockUsers(count)
        var mockHabits: [MockHabit] = []
        for i in stride(from: 0, to: count, by: 1){
            mockHabits.append(MockHabit(user: mockUsers[i], type: mockHabitDatabase?.types.sample(), name: mockHabitDatabase?.names[i], habitDescription: mockHabitDatabase?.habitDescriptions[i], date: nil, imageURL: mockHabitDatabase?.imageUrls.sample()))
        }
        return mockHabits
    }
}
