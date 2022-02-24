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
        ZStack {
            VStack {
                Text(section.sectionname)
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                Toggle(isOn: $hintFlag) {
                    Text("💡ヒントを表示する")
                }
                
                var q = section.questions[index]    // Set next question.
                
                Text(q.question)
                    .font(.system(size: 42))
                    .foregroundColor(Color.pink)
                //  .frame(width: 340.0, height: 180.0)
                Spacer()
                
                VStack {
                    Button(action: {
                        if (q.answer == 1) {
                            okProc()
                            q.isCorrect = true
                        } else {
                            ngProc()
                        }
                    }) {
                        HStack {
                            Image(systemName: "1.square")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                            Text(q.ans1)
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                    .padding(.trailing)
                    
                    Button(action: {
                        if (q.answer == 2) {
                            okProc()
                            q.isCorrect = true
                        } else {
                            ngProc()
                        }
                    }) {
                        HStack {
                            Image(systemName: "2.square")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                            Text(q.ans2)
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                        if (q.answer == 3) {
                            okProc()
                            q.isCorrect = true
                        } else {
                            ngProc()
                        }
                    }) {
                        HStack {
                            Image(systemName: "3.square")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                            Text(q.ans3)
                                .font(.largeTitle)
                            Spacer()
                        }
                    }
                    
                    Button(action: {
                        if (q.answer == 4) {
                            okProc()
                            q.isCorrect = true
                        } else {
                            ngProc()
                        }
                    }) {
                        HStack {
                            Image(systemName: "4.square")
                                .resizable()
                                .frame(width: 50.0, height: 50.0)
                            Text(q.ans4)
                                .font(.largeTitle)
                            Spacer()
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
    
    struct FinishView: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
                Text("Good luck next!")
                    .bold()
                    .font(.largeTitle)
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    VStack {
                        Image(systemName: "cloud.drizzle")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                        Image(systemName: "tortoise")
                            .resizable()
                            .frame(width: 100.0, height: 100.0)
                    }
                }
                Text("Retry...")
                    .font(.title)
            }
        }
    }
    
    struct CompleteView: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            VStack {
                Text("Congratulations!")
                    .bold()
                    .font(.largeTitle)
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    VStack {
                        Image(systemName: "crown")
                            .resizable()
                            .frame(width: 50.0, height: 50.0)
                            .foregroundColor(.red)
                        Image(systemName: "hare")
                            .resizable()
                            .frame(width: 100.0, height: 100.0)
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                playSound(id: 1025) // Fanfare
            }
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
