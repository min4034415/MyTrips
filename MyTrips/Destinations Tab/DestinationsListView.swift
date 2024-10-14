//
//  DestinationsList.swift
//  MyTrips
//
//  Created by Ouimin Lee on 10/14/24.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Destination.name) private var destinations: [Destination]
    @State private var newDestination = false
    @State private var destinationName = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if !destinations.isEmpty {
                    List(destinations) { destination in 
                        HStack {
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
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(destination)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                } else {
                    ContentUnavailableView("No Destinations", systemImage: "globe.desk", description: Text("You have not set up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin"))
                }
            }
            .navigationTitle("MY Destinations")
            .toolbar {
                Button {
                    newDestination.toggle()
                } label: {
                        Image(systemName: "plus.circle.fill")
                }
                .alert("New Destination", isPresented: $newDestination) {
                    TextField("Enter destination name", text: $destinationName)
                    Button("OK") {
                        if !destinationName.isEmpty {
                            let destination = Destination(name: destinationName)
                            modelContext.insert(destination)
                            destinationName = ""
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("Create a new destination")
                }
            }
        }
    }
}

#Preview {
    DestinationsListView()
        .modelContainer(Destination.preview)
}
