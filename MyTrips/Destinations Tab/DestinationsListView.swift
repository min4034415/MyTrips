//
//  DestinationsList.swift
//  MyTrips
//
//  Created by Ouimin Lee on 10/14/24.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Query(sort: \Destination.name) private var destinations: [Destination]
    var body: some View {
        NavigationStack {
            Group {
                if !destinations.isEmpty {
                    List(destinations) { destination in HStack {
                        Image(systemName: "globe")
                            .imageScale(.large)
                            .foregroundColor(.accent)
                        VStack(alignment: .leading, content: {
                            Text(destination.name)
                            Text("^[\(destination.placemarks.count) location](inflect: true)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        })
                    }
                    }
                } else {
                    ContentUnavailableView("No Destinations", systemImage: "globe.desk", description: Text("You have not set up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin"))
                }
            }
            .navigationTitle("MY Destinations")
            .toolbar {
                Button {
                    
                } label: {
                        Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
