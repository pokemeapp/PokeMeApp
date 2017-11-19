//
//  MockHabitDatabase.swift
//  PokeMeApp
//
//  Created by Zsolt Pete on 2017. 11. 04..
//  Copyright © 2017. Zsolt Pete. All rights reserved.
//

import Foundation
import UIKit

class MockHabitDatabase {
    var names: [String] = ["No smoke", "Smoke break", "Drink coffe", "Go run!", "Check my emails", "Talk with boss", "Shopping", "Go to bed", "Drink"]
    var habitDescriptions: [String] = ["Put away cigeratte ⛔️", "Stop and go to cigeratte break 💨", "You did great! You achieved a mug of coffe ☕️", "You pretty slow know. You should go to run 🏃🏿‍♂️", "Hey! Check your emails, you are a important 🤑", "You should talk to the boss! Maybe raises! 🤞🏻", "The fridge is empty! Go to the shop 🍗", "You tired! It's time to sleep! You was great today 🛌", "You like desert! Drink something 🍻"]
    var types: [HabitType] = [.health, .notification, .today, .warning]
    var imageUrls: [String] = ["https://lorempixel.com/output/people-q-c-640-480-7.jpg", "https://lorempixel.com/output/people-q-c-640-480-9.jpg", "https://lorempixel.com/output/people-q-c-640-480-6.jpg", "https://lorempixel.com/output/people-q-c-640-480-1.jpg", "https://lorempixel.com/output/people-q-c-640-480-8.jpg"]
}
