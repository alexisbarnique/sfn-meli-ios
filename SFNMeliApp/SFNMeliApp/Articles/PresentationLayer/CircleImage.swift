//
//  CircleImage.swift
//  SFNMeliApp
//
//  Created by Alexis Barnique on 25/04/2025.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}
