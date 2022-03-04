//
//  ExamView.swift
//  Kikenbutu
//
//  Created by dev on 2022/02/24.
//

import SwiftUI
import AVFoundation

struct ExamView: View {
    var section: QuestSection  // Section data.
    
    @State var index:Int = 0
    @State var okMark = false
    @State var ngMark = false
    @ObservedObject var rm: ResultModel

    @AppStorage("HintFlag") var hintFlag = false
 
    var body: some View {
        let qMax: Int = section.questions.count
        let q = section.questions[index]    // Set next
        let ans = [ "", q.ans1, q.ans2, q.ans3, q.ans4 ]
        
        ZStack {
            VStack {
                HStack {
                    Text("第\(index+1)問")
                        .font(.title)
                    if rm.result[section.id-1][index] {
                        Text("✅")
                    } else {
                        Text("🔲")
                    }
                    Spacer()
                }
                /*
                Text(section.sectionname)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                */
                Text(q.question)
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .foregroundColor(Color.pink)
                 // .frame(minHeight: 0, maxHeight: 120)
                Spacer()
                
                VStack(spacing: 0) {
                    ForEach(1..<5) { num in
                        Button(action: {
                            if (q.answer == num) {
                                okProc()
                                rm.result[section.id-1][index] = true
                            } else {
                                ngProc()
                            }
                        }) {
                            HStack {
                                Image(systemName: "\(num).square")
                                    .resizable()
                                    .frame(width: 50.0, height: 50.0)
                                    .padding(.leading)
                                Text(ans[num])
                                    .multilineTextAlignment(.leading)
                                    .font(.title2)
                                    .frame( minHeight: 0, maxHeight: 150)
                                Spacer()
                            }
                        }
                    }
                }
                Spacer()
                HStack {
                    Button("←前へ") {
                        prevQuest()
                    }
                    .font(.title)
                    .frame(width: 160, height: 50)
                    .foregroundColor(.black)
                    .background(Color.orange)
                    .cornerRadius(32)
                    
                    Text("第\(index+1)問")
                        .font(.largeTitle)
                        .padding(.horizontal)
                    Button("次へ→") {
                        nextQuest(max: qMax)
                    }
                    .font(.title)
                    .frame(width: 160, height: 50)
                    .foregroundColor(.black)
                    .background(Color.orange)
                    .cornerRadius(32)
                }
                Spacer()
                
                if hintFlag {
                    Text(q.hint)
                        .font(.title3)
                        .padding(.horizontal)
                        .foregroundColor(Color.orange)
                        .frame(minHeight: 0, maxHeight: 120)
                }
            }
            if okMark {
                Image("okmark")
                    .resizable()
                    .frame(width: 250, height: 250)
            }
            if ngMark {
                Image("ngmark")
                    .resizable()
                    .frame(width: 300, height: 300)
            }
        }
        .navigationBarTitle("\(section.sectionname)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func resetCount() {
        index = 0
    }
    
    func okProc() {
        playSound(id: 1007) // Ping-pong
        okMark = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            okMark = false
        }
        
    }
    
    func ngProc() {
        playSound(id: 1004) // Boo-boo
        ngMark = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            ngMark = false
        }
        
    }
    
    func nextQuest(max: Int) {
        if index < max - 1 {
            index += 1
        }
    }
    
    func prevQuest() {
        if index > 0 {
            index -= 1
        }
    }
}

func playSound(id: SystemSoundID) {
    var soundIdRing:SystemSoundID = id
    
    if let soundUrl = CFBundleCopyResourceURL(CFBundleGetMainBundle(), nil, nil, nil){
        AudioServicesCreateSystemSoundID(soundUrl, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
    }
}

struct ExamView_Previews: PreviewProvider {
    static var previews: some View {
        ExamView(section: qDatas[0], rm: ResultModel())
.previewInterfaceOrientation(.landscapeLeft)
    }
}
