//
//  Pleny_taskApp.swift
//  Pleny task
//
//  Created by Eslam Salem on 20/09/2023.
//

import SwiftUI

@main
struct Pleny_taskApp: App {

    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: AppConstants.tokenKey) != nil {
                PostsView(viewModel: PostViewModel(repository: ServerGalleryRepo()))
            } else {
                LoginView(viewModel: LoginViewModel(repository: ServerAuthRepo()))
            }
        }
    }
}
