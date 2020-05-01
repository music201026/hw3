//
//  BlendView.swift
//  hw3
//
//  Created by User16 on 2020/5/2.
//  Copyright © 2020 User16. All rights reserved.
//

import SwiftUI

struct BlendView: View {
    var roles = ["星空", "抬棺材", "馬力歐", "海大"]
    var selectedName: String
    @State private var selectedblend = "星空"
    var body: some View {
        return ZStack {
           Image(selectedName)
              .resizable()
           Image("星空")
              .resizable()
              .blendMode(.screen)
        }
    }
struct BlendView_Previews: PreviewProvider {
    static var previews: some View {
        BlendView(selectedName: "阿天")
    }
}
}

