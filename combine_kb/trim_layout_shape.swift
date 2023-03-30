//
//  trim_layout_shape.swift
//  combine_kb
//
//  Created by reborn on 2021/10/27.
//
import Combine
import SwiftUI

struct trim_layout_shape: View {
    @State private var completionAmount: CGFloat = 0.0
    
    //타이머 설정
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            ScrollView{
                Circle()
                    .trim(from: 0, to: completionAmount)
                    .stroke(AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center),lineWidth: 20)
                    
                    .frame(width: 200, height: 200)
                    
                    //시계방향으로 돌아갈수 있도록
                    .rotationEffect(.degrees(-90))
                    
                    //타이머를 표현할때 onReceive는 필수이다.
                    .onReceive(timer) { _ in
                        withAnimation {
                            if completionAmount == 1 {
                                completionAmount = 0
                            } else {
                                completionAmount += 0.2
                            }
                        }
                    }
                
                HStack(spacing: 10) {
                    Text("나랏말싸미 듕귁에 달아 문자와로 서르 사맛디 아니할쎄")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(Color.blue)
                       
                    Text("이런 전차로 어린 백셩이 니르고져 홇베이셔도")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(Color.green)
                        
                    Text("마참네 제 뜨들 시러펴디 몯핧 노미하니아 내 이랄 윙하야 어엿비너겨 새로 스믈 여듫 짜랄 맹가노니")
                        .padding()
                        .frame(maxHeight: .infinity)
                        .background(Color.yellow)
                       
                }
                //높이가 동일하게
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: 200)
                HStack(spacing: 10) {
                    Text("나랏말싸미 듕귁에 달아 문자와로 서르 사맛디 아니할쎄")
                        .layoutPriority(3)
                    //숫자가 높을수록 우선순위 높아짐
                    Text("이런 전차로 어린 백셩이 니르고져 홇베이셔도")
                        .layoutPriority(1)
                    Text("마참네 제 뜨들 시러펴디 몯핧 노미하니아 내 이랄 윙하야 어엿비너겨 새로 스믈 여듫 짜랄 맹가노니")
                        .layoutPriority(3)
                }
                .lineLimit(1)
                .padding()
                
                HStack {
                               Text("둥근모양")
                                   .font(.title)
                               Spacer()
                           }
                           ZStack {
                               Rectangle().frame(height: 10) //가운데 선
                               HStack {
                                   Circle().foregroundColor(.blue)      //원
                                   Ellipse().foregroundColor(.green)    //타원
                                   Capsule().foregroundColor(.orange)   //캡슐
                                   RoundedRectangle(cornerRadius: 30).fill(Color.gray)  //둥근모서리
                               }.frame(width: .infinity, height: 300)
                           }
                HStack {
                    Text("각진모양")
                        .font(.title)
                    Spacer()
                }
                ZStack {
                    Rectangle().frame(height: 10)  //가운데 선
                    
                    HStack {
                        Color.red   //이렇게만해도 직사각형이 생성된다.
                        Rectangle().fill(Color.blue)
                        RoundedRectangle(cornerRadius: 0).fill(Color.purple)
                    }.frame(width: .infinity, height: 300)
                }
            }
        }
    }
}




struct ContentView1: View {
    @ObservedObject   var coursesVM = CourseViewModel1()
    var body: some View {
        NavigationView {
            ScrollView {
                Text(coursesVM.messages)
            }
            .navigationBarTitle("Courses")
            .navigationBarItems(trailing:
                Button(action: {
                print("Fetching json data")
                self.coursesVM.messages = "옵져버 뷰모델 내부 텍스트 변경" }
                       , label: {
                Text("Fetch Courses")
                                }
                      )
            )
        }
    }
    class CourseViewModel1: ObservableObject {
        @Published var messages = "MVVM text"
    }
}



struct trim_layout_shape_Previews: PreviewProvider {
    static var previews: some View {
        trim_layout_shape()
    }
}
