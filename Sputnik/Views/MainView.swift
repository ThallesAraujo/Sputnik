//
//  MainView.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 23/08/20.
//

import SwiftUI



struct ContentView: View {
    
    @State private var url = "Pesquisar ou digitar url"
    @State private var tabs = []
    @State var navBarHidden: Bool = true
    
    var body: some View {
        
            GeometryReader{geometry in
                
                HStack{
                    Rectangle().fill(Color.clear).frame(width: geometry.size.width, height: UIHelper.getStatusBarHeight())
                }.background(BlurView(style: .systemThinMaterial)).edgesIgnoringSafeArea(.all).zIndex(2)

                NavigationView{
                ZStack{

                    
                    WebPageView(url: url).edgesIgnoringSafeArea(.all)
                
                    VStack{
                        Spacer()
                        HStack{
                            Image("arrow.back").padding()
                            NavigationLink(destination: EnterUrlView(completion: { (url) in
                                self.url = url
                            })){
                                ZStack{
                                    RoundedRectangle(cornerRadius: 30).stroke(Color.gray, lineWidth: 3).frame(height: 30)
                                    Text(self.url).foregroundColor(.white)
                                }
                            }
                            Image("arrow.next").padding()
                        }.frame(height: 40).background(BlurView(style: .systemMaterialDark)).cornerRadius(15).padding()
                    }
                    
                }.navigationBarTitle("")
                .navigationBarHidden(self.navBarHidden)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                    self.navBarHidden = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                    self.navBarHidden = false
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


