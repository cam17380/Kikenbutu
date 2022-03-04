//
//  ContentView.swift
//  Kikenbutu
//
//  Created by dev on 2022/02/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var rm1 = ResultModel()
    @ObservedObject var rm2 = ResultModel()
    @State var kai = 1
    
    var body: some View {
        TabView(selection: $kai







        ) {
            ExamSectionView(quests: qDatas, title: "kikenbutu1", rm: rm1)
                .tabItem {
                Text("第１回問題")

            }.tag(1)
            ExamSectionView(quests: qDatas2, title: "kikenbutu2", rm: rm2)
                .tabItem {
                Text("第２回問題")

            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
