//
//  StarView.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 01/02/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI

struct StarButton: View {
    @Binding var isSet: Bool
    var body: some View {
        HStack {
            Button {
                isSet.toggle()
            } label: {
                Image(systemName: isSet ? "star.fill" : "star")
                    .foregroundColor(isSet ? .yellow : .gray)
            }.frame(width: 60.0, height: 60.0)
        }
    }
}

struct StarView_Previews: PreviewProvider {
    static var previews: some View {
        StarButton(isSet: .constant(false))
    }
}
