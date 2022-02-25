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
    @State var hintFlag = false
 
    var body: some View {
        let qMax: Int = section.questions.count
        var q = section.questions[index]    // Set next
        let ans = [ "", q.ans1, q.ans2, q.ans3, q.ans4 ]
        
        ZStack {
            VStack {
                HStack {
                    Toggle(isOn: $hintFlag) {
                        Text("💡ヒントを表示する")
                    }
                    Spacer()
                    if q.isCorrect {
                        Text("✅")
                    } else {
                        Text("🔲")
                    }
                }
                Text(section.sectionname)
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                
                Text(q.question)
                    .lineLimit(4)
                    .multilineTextAlignment(.leading)
                    .font(.largeTitle)
                    .foregroundColor(Color.pink)
                //  .frame(width: 340.0, height: 180.0)
                Spacer()
                
                VStack {
                    ForEach(1..<5) { num in
                        Button(action: {
                            if (q.answer == num) {
                                okProc()
                                q.isCorrect = true
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
                                    .lineLimit(4)
                                    .multilineTextAlignment(.leading)
                                    .font(.title)
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
                    .font(.largeTitle)
                    .frame(width: 160, height: 80)
                    .foregroundColor(.black)
                    .background(Color.orange)
                    .cornerRadius(32)
                    
                    Text("第\(index+1)問")
                        .font(.largeTitle)
                        .padding(.horizontal)
                    Button("次へ→") {
                        nextQuest(max: qMax)
                    }
                    .font(.largeTitle)
                    .frame(width: 160, height: 80)
                    .foregroundColor(.black)
                    .background(Color.orange)
                    .cornerRadius(32)
                }
                Spacer()
                
                if hintFlag {
                    Text(q.hint)
                        .font(.largeTitle)
                        .padding(.horizontal)
                        .foregroundColor(Color.orange)
                }
            }
            if okMark {
                Image("okmark")
                    .resizable()
                    .frame(width: 300, height: 300)
            }
            if ngMark {
                Image("ngmark")
                    .resizable()
                    .frame(width: 300, height: 300)
            }
        }
        .navigationBarTitle("丙種危険物取扱者 試験問題")
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
        ExamView(section: kukus[0])
    }
}
