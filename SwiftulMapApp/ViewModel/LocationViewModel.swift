//
//  LocationViewModel.swift
//  SwiftulMapApp
//
//  Created by 仲村士苑 on 2024/12/21.
//

import Foundation
import MapKit
import SwiftUI


class LocationsViewModel: ObservableObject {
    
    // all loaded locations
    @Published var locations: [Location] 
    
    // current location map
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
//    @Published var mapRegion:MKCoordinateRegion = MKCoordinateRegion()  <-this is old
    
    
    // current region on map
    @Published var mapRegion:MapCameraPosition
    let mapSpan =  MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    
    @Published var showLocationsList: Bool = false
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
//        self.updateMapRegion(location: locations.first!)
        self.mapRegion = .region(MKCoordinateRegion(
            center: locations.first!.coordinates,
            span: mapSpan
        ))
    }
    
    
    private func updateMapRegion(location: Location) {
        mapRegion = .region(MKCoordinateRegion(center: location.coordinates, span: mapSpan))
    }
    
    func toggleLocationsList(){
        withAnimation(.easeInOut){
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location:Location){
        withAnimation(.easeInOut){
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed(){
        //get the current indx
        
        guard let currentIndex = locations.firstIndex(where: { location in
            return location == mapLocation
        })else{
            print("could not find the current index in locations array! should never happen")
            return
        }
        
        // check if the nextIndex is valid
        
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex)else{
            // if next index is invalid
            // start from 0
            guard let firstLocation = locations.first else{
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        
        
        // if next is valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
    
    
}
