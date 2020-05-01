//
//  ContentView.swift
//  hw3
//
//  Created by User16 on 2020/5/1.
//  Copyright © 2020 User16. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let player = AVPlayer()
    var roles = ["尚青", "阿天", "洛基", "看到鬼","班森","鳥哥","棒棒伯"]
    @State private var selectedName = "棒棒伯"
    @State private var brightnessAmount: Double = 0
    @State private var radius: CGFloat = 0
    @State private var birthday = Date()
    @State private var name = ""
    @State private var couplename = ""
    @State private var isSingle = false
    @State private var show = false
    @State private var showAlert = false
    @State private var number = 0
    @State private var showSecondView = false
    let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
       dateFormatter.dateStyle = .medium
       return dateFormatter
    }()
   var body: some View {
    NavigationView{
      VStack {
        ZStack{
            Image(selectedName)
               .resizable()
               .scaledToFit()
               .frame(height:400)
               .brightness(brightnessAmount)
               .blur(radius: radius)
            Circle()
                .stroke(LinearGradient(gradient: Gradient(colors: [Color("Head"),Color("Mid"),Color("Dark"), Color("Light")]), startPoint: .leading, endPoint: .trailing),lineWidth: 10)
                .frame(width: 320, height: 320)
                if isSingle{
                    Image(systemName: "person.fill").imageScale(.large)
                    .frame(width: 60, height: 60)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Head"),Color("Mid"),Color("Dark"), Color("Light")]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Circle())
                    .offset(x: 90, y:130)
                    Circle()
                    .stroke(Color.black,lineWidth:3)
                    .frame(width: 62, height: 62)
                    .offset(x: 90, y:130)
                }
                else{
                    Image(systemName: "person.2.fill").imageScale(.large)
                    .frame(width: 60, height: 60)
                    .background(LinearGradient(gradient: Gradient(colors: [Color("Head"),Color("Mid"),Color("Dark"), Color("Light")]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Circle())
                    .offset(x: 90, y:130)
                    Circle()
                    .stroke(Color.black,lineWidth:3)
                    .frame(width: 62, height: 62)
                    .offset(x: 90, y:130)
                }

            }
        
            Picker(selection: $selectedName, label: Text("選擇角色")) {
               ForEach(roles, id: \.self) { (role) in
                  Text(role)
               }
            }
            .pickerStyle(SegmentedPickerStyle())
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(30)
            .shadow(radius: 30)
        
            Toggle("你單身嗎？",isOn: $isSingle)
        
            Form{
                BrightnessSlider(brightnessAmount: self.$brightnessAmount)
                BlurSlider(radius:self.$radius)
                if isSingle{
                    TextField("你的英文名字", text: $name)
                          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                    DatePicker("哪一天加入天兵公園", selection: $birthday, displayedComponents: .date)
                    Text("我是\(name)，我另一半叫\(couplename)，\(dateFormatter.string(from: birthday))加入天兵公園<3")
                }
                else {
                    TextField("你的英文名字", text: $name)
                          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                    TextField("你另外一半的名字", text: $couplename)
                          .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.purple, lineWidth: 2))
                    DatePicker("哪一天加入天兵公園", selection: $birthday, displayedComponents: .date)
                    Text("我是\(name)，我另一半叫\(couplename)，\(dateFormatter.string(from: birthday))加入天兵公園<3")
                }

            }
        HStack{
            Button("你浪費了多少青春") {
                self.showSecondView = true
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    self.number += 1
                }
            }
            .sheet(isPresented: $showSecondView) {TimeView(number: self.number)}
            .padding()
        
            NavigationLink(destination: BlendView(selectedName: selectedName)) {
                Text("我填好ㄌ")
                .padding()
            }

            Button(action: {
               self.showAlert = true
            }) {
               VStack {
                  Text("我懶得填")
               }
            }.alert(isPresented: $showAlert) { () -> Alert in
               let answer = ["懶惰是愚者的休暇", "懶惰沒有牙齒，但卻可以吞噬人的智慧","勤奮的人是時間的主人，懶惰的人是時間的奴隸"].randomElement()!
               return Alert(title: Text(answer))
            }
        }


   }
}
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}

struct BrightnessSlider: View {
    @Binding var brightnessAmount: Double
    var body: some View {
        HStack {
            Text("亮度")
            Slider(value: $brightnessAmount, in: 0...1, minimumValueLabel: Image(systemName: "sun.max.fill").imageScale(.small), maximumValueLabel: Image(systemName: "sun.max.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}

struct BlurSlider: View {
     @Binding var radius: CGFloat
    var body: some View {
        HStack {
            Text("模糊")
            Slider(value: $radius, in: 0...50, minimumValueLabel: Image(systemName: "minus.circle.fill").imageScale(.small), maximumValueLabel: Image(systemName: "plus.circle.fill").imageScale(.large)) {
                Text("")
            }
        }
    }
}
