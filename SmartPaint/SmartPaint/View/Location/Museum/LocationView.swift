//
//  LocationView.swift
//  SmartPaint
//
//  Created by jackychoi on 7/1/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment:.topTrailing){
            NavigationView{
                List(LocationArray){ location in
                    NavigationLink(destination: LocationDetail(location: location)) {
                        LocationRow(location: location)
                    }
                }
                .navigationBarTitle("Museum")
                .listStyle(.plain)
            }
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "menubar.arrow.down.rectangle")
                    .foregroundStyle(.black)
                    .font(.title2)
            }
            .padding()
        }
    }
}

struct LocationRow: View{
    let location: Location
    var body: some View{
        HStack{
            Image(location.locationImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150,height: 150)
            VStack(alignment: .leading){
                Text(location.locationName)
                    .font(.system(size: 21,weight: .medium,design: .default))
                    .padding(.leading)
            }
        }
    }
}

#Preview {
    LocationView()
}
