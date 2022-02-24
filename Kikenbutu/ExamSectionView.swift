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
                    HStack {
                        Text(quest.sectionname)
                        Spacer()
                        if quest.isComplete {
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
        }
    }
}

struct ExamSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExamSectionView(quests: kukus, title: "kikenbutu")
    }
}
