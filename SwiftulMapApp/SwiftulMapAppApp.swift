//
//  SwiftulMapAppApp.swift
//  SwiftulMapApp
//
//  Created by 仲村士苑 on 2024/12/20.
//

import SwiftUI

@main
struct SwiftulMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
