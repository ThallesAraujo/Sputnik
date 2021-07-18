//
//  ViewExtension.swift
//  ThallesBrowser
//
//  Created by Thalles Araújo on 06/09/20.
//

import Foundation
import SwiftUI

extension View {
    func hideNavigationBar() -> some View {
        self
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
    }
}
