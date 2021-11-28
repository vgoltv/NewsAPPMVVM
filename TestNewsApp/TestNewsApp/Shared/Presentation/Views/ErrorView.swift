//
//  ErrorView.swift
//  TestNewsApp
//
//  Created by Natalia  Stele on 01/06/2021.
//

import SwiftUI

struct ErrorView: View {
    typealias ErrorViewActionHandler = () -> Void
    let error: Error
    let handler: ErrorViewActionHandler

    internal init(error: Error, handler: @escaping ErrorViewActionHandler) {
        self.error = error
        self.handler = handler
    }

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.icloud.fill")
                .font(.system(size: 50,weight: .heavy))
                .padding(.bottom,4)

            Text("Error")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            Text(error.localizedDescription)
                .font(.footnote)
                .multilineTextAlignment(.center)

            Button(action: {
                self.handler()
            },
                   label: { Image(systemName: "arrow.counterclockwise").imageScale(.large) })
                .buttonStyle(PlainButtonStyle())
                .padding()
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.decodingError, handler: {})
            .previewLayout(.sizeThatFits)
    }
}
