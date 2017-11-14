//
//  MockUserGenerator.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation

class MockUserGenerator {
    
    var options: [MockUserOption]
    var mockUserDatabase: MockUserDatabase?
    
    init(options: [MockUserOption]) {
        self.options = options
        self.mockUserDatabase = MockUserDatabase()
    }
    
    func createMockUsers(_ count: Int) -> [MockUser] {
        var mockUsers: [MockUser] = []
        for _ in stride(from: 0, to: count, by: 1){
            mockUsers.append(MockUser())
        }
        for option: MockUserOption in self.options {
            switch option {
            case .firstName:
                mockUsers = self.addFirstName(mockUsers)
            case .lastName:
                mockUsers = self.addLastName(mockUsers)
            case .fullName:
                mockUsers = self.addFullName(mockUsers)
            case .imageURL:
                mockUsers = self.addImageUrl(mockUsers)
            default:
                print("Default")
            }
        }
        return mockUsers
    }
    
    private func addFirstName(_ mockUsers: [MockUser]) -> [MockUser]{
        for mockUser in mockUsers {
            mockUser.firstName = mockUserDatabase?.firstNames.sample()
        }
        return mockUsers
    }
    
    private func addLastName(_ mockUsers: [MockUser]) -> [MockUser]{
        for mockUser in mockUsers {
            mockUser.lastName = mockUserDatabase?.lastNames.sample()
        }
        return mockUsers
    }
    
    private func addImageUrl(_ mockUsers: [MockUser]) -> [MockUser]{
        for mockUser in mockUsers {
            mockUser.imageURL = mockUserDatabase?.imageUrls.sample()
        }
        return mockUsers
    }
    
    private func addFullName(_ mockUsers: [MockUser]) -> [MockUser]{
        for mockUser in mockUsers {
            if let firstName = mockUser.firstName, let lastName = mockUser.lastName {
                mockUser.fullName = "\(firstName)" + " " +  "\(lastName)"
            }
        }
        return mockUsers
    }
}
