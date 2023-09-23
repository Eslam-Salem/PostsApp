//
//  SearchbarView.swift
//  Pleny task
//
//  Created by Eslam Salem on 21/09/2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var placeholder: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField(placeholder, text: $text, onCommit: onSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: onSearch) {
                Text("Search")
            }
        }
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        let text = Binding<String>(
            get: { "Some Text" },
            set: { _ in }
        )

        return SearchBarView(text: text, placeholder: "placeholder") {}
    }
}
