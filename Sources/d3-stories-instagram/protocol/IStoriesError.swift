//
//  IStoriesError.swift
//
//
//  Created by Igor Shelopaev on 05.07.2022.
//

import SwiftUI


/// Define interface for errors related to validation of data set ``IStory``
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 6.0, *)
public protocol IStoriesError: Error, Hashable {

    var description: String { get }
}

extension IStoriesError {

    /// Tpl for demonstrating an error
    @ViewBuilder
    static func builder(_ errors: [Self]) -> some View {
        let title = "Data validation errors".uppercased()

        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text(title).multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                }
                    .frame(maxWidth: .infinity)
                    .font(.system(.title))
                ForEach(errors, id: \.self) { e in
                    Text("\(e.description)").padding(.top, 2)
                }
            }.padding()
        }.padding()
            .background(.thickMaterial)
    }

}
