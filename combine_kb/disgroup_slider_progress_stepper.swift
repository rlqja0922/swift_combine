//
//  disgroup_slider_progress_stepper.swift
//  combine_kb
//
//  Created by reborn on 2021/10/20.
//

import SwiftUI

struct disgroup_slider_progress_stepper: View {
    @State var Details = false
    @State var Details1 = false
    @State var down : Double = 0.0
    @State var down2 : Double = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
        func makeBody(configuration: Configuration) -> some View {
            ProgressView(configuration)
                .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                        radius: 4.0, x: 1.0, y: 2.0)
        }
    }
    var body: some View {
        VStack(alignment: .leading){
            ScrollView{
                DisclosureGroup("그룹?",isExpanded: $Details) {
                    VStack{
                        Text("테스트")
                            .frame(width: 200, height: 50)
                            .background(Color.purple)
                            .gesture(TapGesture().onEnded({_ in
                                down = 0.0
                                down2 = 0.0
                            }))
                        DisclosureGroup("그룹2 프로그레스, 타이머") {
                            ProgressView("프로그래스 다운로드", value: down, total: 100)
                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                .onReceive(timer) { _ in
                                    if down < 100 {
                                        down += 3
                                    }
                                }
                            VStack{
                                Text("터치 프로그레스")
                                    .frame(width: 150, height: 30)
                                    .background(Color.purple)
                                    .gesture(TapGesture().onEnded({_ in
                                        if down2 < 100 {
                                            down2 += 5
                                        }
                                    }))
                                    .padding(.bottom)
                                ProgressView(value: down2, total: 100)
                            }
                                .progressViewStyle(DarkBlueShadowProgressViewStyle())
                            
                            ProgressView(value: down2)
                                   .progressViewStyle(CircularProgressViewStyle(tint: .red))
                                   .padding()
                        }.padding()
                          
                        DisclosureGroup("그룹3 슬라이드") {
                            SliderView()
                        }.padding()
                    }
                }
                DisclosureGroup("그룹1",isExpanded: $Details1) {
                    StepperView()
                }
            }
            
            Spacer()
        }
    }
}

struct SliderView: View {
    @State var sliderValue1: Double = 50
    @State var sliderValue2: Double = 50
    @State var color: Color = .red
    
    var minimumValueLable: Double = 0.0
    var maximumValueLable: Double = 100
    
    var body: some View {
        VStack {
            Text("슬라이더")
                .font(.title)
                .padding(.bottom, 100)
            
            HStack {
                Text("현재 슬라이더의 값은")
                Text(
                    (String(format: "%.0f", sliderValue1))
                )
                Text("입니다.")
            }
            
            HStack {
                Text("\(Int(minimumValueLable))")
            Slider(value: $sliderValue1, in: 0...100, step: 10.0)
                Text("\(Int(maximumValueLable))")
            }
          
            Divider().padding(.vertical, 50)

                                                        //소수점 자리수
            Text("현재 슬라이더의 값은 \(sliderValue2, specifier: "%.0f") 입니다.")
                .foregroundColor(color)
            
            Slider(value: $sliderValue2,in: 0...100, step: 1.0,
                   //실행이 되면 구현될 액션
                   onEditingChanged: { (_) in
                    color = .blue
                   },
                   minimumValueLabel: Text("0"),
                   maximumValueLabel: Text("100")) {
                
                //Text("some lable")
            }
            .accentColor(.orange)
        }
        .padding()
    }
}
struct StepperView : View {
    @State private var sleepAmount = 8.0
    @State private var value = 0
    @State var age = 26
    let colors: [Color] = [.orange, .red, .gray, .blue,
                           .green, .purple, .pink]

    //증가값 함수
    func incrementStep() {
        //클릭마다 +1씩 증가
        value += 1
        /* value가 colors개수보다 작거나 같으면 value는 0
              즉, pink색이 되면 -> orange색으로 돌아감 */
        if value >= colors.count { value = 0 }
        let cancellable = colors.publisher
            .sink(receiveCompletion: { print ("completion: \($0)") },
                  receiveValue: {
                print ("value: \($0)")
                if $0 == colors[value]{
                    print("같은색이다")
                }
            })
    }
    //감소값 함수
    func decrementStep() {
        //클릭마다 -1씩 증가
        value -= 1
        /* value가 0보다 작으면 value는 colors개수에 -1
              즉, orange색에서 -> pink색으로 돌아감 */
        if value < 0 { value = colors.count - 1 }
        let myRange = (0...3)
        let cancellable = myRange.publisher
            .sink(receiveCompletion: { print ("completion: \($0)") },
                  receiveValue: { print ("value: \($0)") })
    }

    var body: some View {
             /*증가버튼을 누르면: incrementStpe이 실행되고,
               감소버튼을 누르면: decrementStep이 실행된다. */
        Stepper(onIncrement: incrementStep,
            onDecrement: decrementStep) {
            
            Text("값: \(value) 색상: \(colors[value].description)")
        }
        .padding(5)
        //색상을 할당해준다.
        .background(colors[value])
        
        Stepper("나이", value: $age, in: 0...100)
        Text("내 나이는 \(age) 이다")
        
        Stepper(value: $sleepAmount, in: 2...12, step: 0.25) {
            Text("\(sleepAmount, specifier: "%g") hours")
        }
        .padding()
    }
}
struct disgroup_slider_progress_stepper_Previews: PreviewProvider {
    static var previews: some View {
        disgroup_slider_progress_stepper()
    }
}
