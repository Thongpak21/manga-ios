//
//  Appstate.swift
//  Manga
//
//  Created by Thongpak on 4/4/2563 BE.
//  Copyright © 2563 Thongpak. All rights reserved.
//

import SwiftUI
import Combine

struct AppState: Equatable {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
}

extension AppState {
    struct UserData: Equatable {
//        var countries: Loadable<[Country]> = .notRequested
    }
}

extension AppState {
    struct ViewRouting: Equatable {

    }
}

extension AppState {
    struct System: Equatable {
        var isActive: Bool = false
        var keyboardHeight: CGFloat = 0
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system
}

#if DEBUG
extension AppState {
    static var preview: AppState {
        var state = AppState()
//        state.userData.countries = .loaded(Country.mockedData)
        state.system.isActive = true
        return state
    }
}
#endif
