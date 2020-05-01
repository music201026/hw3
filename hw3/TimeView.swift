//
//  BlendView.swift
//  hw3
//
//  Created by User16 on 2020/5/2.
//  Copyright © 2020 User16. All rights reserved.
//

import SwiftUI

struct TimeView: View {
    var number: Int
    
    init(number: Int) {
        self.number = number
        print("NumberView init \(number)")
    }
    
    var body: some View {
        
        print("NumberView body \(number)")
        return  Image(systemName: "\(number % 51).circle")
        .resizable()
        .scaledToFit()
        .background(Image("星空"))
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView(number: 5)
    }
}
