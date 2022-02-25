//
//  ExamSectionView.swift
//  Kikenbutu
//
//  Created by dev on 2022/02/24.
//

import SwiftUI

struct ExamSectionView: View {
    var quests: [QuestSection]  // All questions(json file) data.
    var title: String   // Questions title.

    @EnvironmentObject var rm: ResultModel

    @AppStorage("HintFlag") var hintFlag = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(quests) { quest in
                    NavigationLink(destination: ExamView(section: quest)) {
                        SectionTitle(quest: quest)
                    }
                }
                Spacer()
                Toggle(isOn: $hintFlag) {
                    Text("💡ヒントを表示する")
                }
            }
        }
    }
}

struct ExamSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExamSectionView(quests: qDatas, title: "kikenbutu")
            .environmentObject(ResultModel())
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

struct SectionTitle: View {
    var quest: QuestSection
    @EnvironmentObject var rm: ResultModel

    var body: some View {
        HStack {
            Text(quest.sectionname)
            Spacer()
            let ok = rm.result[quest.id-1].filter{$0}.count
            let total = rm.result[quest.id-1].count
            Text("\(ok)")
            Text("/\(total)")
            if (Double(ok) / Double(total)) > 0.59 {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            } else {
                Image(systemName: "star")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
}
