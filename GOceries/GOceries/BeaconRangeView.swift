//
//  ContentView.swift
//  BeaconDetector
//
//  Created by Sjoerd van Gerwen on 08/03/2022.
//
import Combine
import CoreLocation
import SwiftUI

struct BeaconRangeView: View {
    @ObservedObject var detector = BeaconDetector()
    
    
    var body: some View {
        if detector.lastDistance == .immediate{
            //return Text("RIGHT HERE")
            return Text("Less than one meter away!")
                .foregroundColor(.green)

        } else if detector.lastDistance == .near {
            //return Text("GETTING CLOSE NOW...")
            return Text("Less than 5 m away.")
                .foregroundColor(.blue)

        } else if detector.lastDistance == .far {
            //return Text("FAR AWAY")
            return Text("50-20 meter away.")
                .foregroundColor(.orange)

        } else {
            //return Text("UNKNOWN")
            return Text("> 50 meter away.")

        }
    }
}

struct BeaconRangeView_Previews: PreviewProvider {
    static var previews: some View {
        BeaconRangeView()
    }
}
