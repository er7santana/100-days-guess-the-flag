//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Eliezer Rodrigo Beltramin de Sant Ana on 15/07/24.
//

import SwiftUI

struct FlagImage: View {
    
    let imageName: String
    
    init(_ imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .shadow(radius: 5)
    }
}

#Preview {
    FlagImage("UK")
}
