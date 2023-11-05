//
//  SetApp.swift
//  Set
//
//  Created by Larry Scherr on 11/4/23.
//

import SwiftUI

@main
struct SetApp: App {
    @StateObject var game = SetGameViewModel()

    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
