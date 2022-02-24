//
//  ContentView.swift
//  Kikenbutu
//
//  Created by dev on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ExamSectionView(quests: kukus, title: "kikenbutu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
