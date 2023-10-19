//
//  File.swift
//  Wonderous WidgetExtension
//
//  Created by Shawn on 2023-10-19.
//

import Foundation
import SwiftUI


// TODO: Add support for showing the last-found artifact from the app
// Load an image from the flutter assets bundle
struct BgImage : View {
    var entry: WonderousEntry
    var body: some View {
        let image = bundle.appending(path: "/assets/images/widget/background-empty.jpg").path();
        print(image)
        if let uiImage = UIImage(contentsOfFile: image) {
            let image = Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill) // Fill the entire view
               // .edgesIgnoringSafeArea(.all) // Ignore the safe area
            return AnyView(image)
        }
        print("The image file could not be loaded")
        return AnyView(EmptyView())
    }
    
}

// Display a previously loaded remote image
struct NetImage : View {
    var imageData: Data?
    var body: some View {
        if imageData != nil, let uiImage = UIImage(data: imageData!) {
            return Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 26.0)
        } else {
            return Image("EmptyChart")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 26.0)
        }
    }
}

struct GaugeProgressStyle: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0
        
        return ZStack {
            Circle()
                .stroke(.gray, style: StrokeStyle(lineWidth: 2))
            Circle()
                .trim(from: 0, to: fractionCompleted)
                .stroke(.red, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(90))
        }
    }
}
