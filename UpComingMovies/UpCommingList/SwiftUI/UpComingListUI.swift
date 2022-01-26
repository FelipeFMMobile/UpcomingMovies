//
//  UpComingListUI.swift
//  UpComingMovies
//
//  Created by Felipe Menezes on 23/01/22.
//  Copyright © 2022 FMMobile. All rights reserved.
//

import SwiftUI

struct UpComingListUI: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                Spacer()
                Text("California")
                    .font(.subheadline)
            }
        }.padding(24)
    }
}

struct UpComingListUI_Previews: PreviewProvider {
    static var previews: some View {
        UpComingListUI()
    }
}
