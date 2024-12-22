//
//  LocationsView.swift
//  SwiftulMapApp
//
//  Created by 仲村士苑 on 2024/12/21.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    @EnvironmentObject private var vm : LocationsViewModel
    
//    @State private var mapRegion = MapCameraPosition.region(MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))

    var body: some View {

        ZStack{
            withAnimation(.easeInOut){
                Map(position: $vm.mapRegion)
            }
            VStack(spacing: 0){
                header
                    .padding()
                Spacer()

                // this zstack stack all at once so that why it shows me kind of shadow without using if statement so that we have to use if stataement
                
                ZStack{
                    ForEach(vm.locations){ location in
                        if vm.mapLocation == location {
                            LocationPreviewView(location: location)
                                .shadow(color:.black.opacity(0.3),
                                        radius: 20)
                                .padding()
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing),
                                    removal: .move(edge: .leading)))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}


extension LocationsView {
    
    private var  header : some View{
   
            VStack{
                Button {
                    vm.toggleLocationsList()
                } label: {
                    Text(vm.mapLocation.name + "," + vm.mapLocation.cityName)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundStyle(.black)
                        .frame(height:55)
                        .frame(maxWidth:.infinity)
                        .animation(.none, value: vm.mapLocation)
                        .overlay(alignment: .leading) {
                            Image(systemName: "arrow.down")
                                .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 :0 ))
                                .font(.headline)
                                .foregroundStyle(.black)
                                .padding()
                        }
                }

       
                if vm.showLocationsList{
                    LocationsListView()
                }
            }
            .background(.thickMaterial)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 15)
            .padding()
            

        
    }
}
