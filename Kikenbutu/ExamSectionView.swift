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
    
    var body: some View {
        NavigationView {
            List(quests) { quest in
                NavigationLink(destination: ExamView(section: quest)) {
                    SectionTitle(quest: quest)
                }
            }
        }
    }
}

struct ExamSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExamSectionView(quests: kukus, title: "kikenbutu")
    }
}

struct SectionTitle: View {
    var quest: QuestSection
    
    var body: some View {
        HStack {
            Text(quest.sectionname)
            Spacer()
            let ok = quest.questions.filter{$0.isCorrect}.count
            let total = quest.questions.count
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
