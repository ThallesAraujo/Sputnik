//
//  EnterUrlView.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 06/09/20.
//

import Foundation
import SwiftUI
struct EnterUrlView: View{
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var url = ""
    var completion: (String) -> Void
    
    var body: some View{
        
        ZStack{
            BlurView()
            VStack{
                TextField("Pesquisar ou navegar até url..", text: $url)
                Button("Carregar!", action: {
                    presentationMode.wrappedValue.dismiss()
                    completion(self.url)
                })
            }
        }
    }
    
    
}

