//

//  ContentView.swift

//  BeaconDetector

//

//  Created by Sjoerd van Gerwen on 08/03/2022.

//

import Combine

import CoreLocation

import SwiftUI



class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {

    var didChange = PassthroughSubject<Void, Never>()

    var locationManager: CLLocationManager?

    @Published var lastDistance = CLProximity.unknown

    

    override init() {

        super.init()

        

        locationManager = CLLocationManager()

        locationManager?.delegate = self

        locationManager?.requestWhenInUseAuthorization()

    }

    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        if status == .authorizedWhenInUse {

            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {

                if CLLocationManager.isRangingAvailable(){

                    startScanning()

                }

            }

        }

    }

    

    func startScanning() {

        

        let uuid = UUID(uuidString: "2F234454-CF6D-4A0F-ADF2-F4911BA9FFA6")!

        

        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 1, minor: 2)

        

        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint, identifier: "MyBeacon")

        

        locationManager?.startMonitoring(for: beaconRegion)

        locationManager?.startRangingBeacons(satisfying: constraint)

    }

    

    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {

        if let beacon = beacons.first {

            update(distance: beacon.proximity)

        } else {

            update(distance: .unknown)

        }

    }

    

    func update (distance:CLProximity) {

        lastDistance = distance

        didChange.send(())

    }

}



struct BigText: ViewModifier{

    func body(content: Content) -> some View {

        content

            .font(Font.system(size: 72, design: .rounded))

            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity)

    }

}





struct BeaconView: View {

    @ObservedObject var detector = BeaconDetector()

    

    

    var body: some View {

        if detector.lastDistance == .immediate{

            return Text("RIGHT HERE")

                .modifier(BigText())

                .background(Color.green)

                .edgesIgnoringSafeArea(.all)

        } else if detector.lastDistance == .near {

            return Text("GETTING CLOSE NOW...")

                .modifier(BigText())

                .background(Color.orange)

                .edgesIgnoringSafeArea(.all)

        } else if detector.lastDistance == .far {

            return Text("FAR AWAY")

                .modifier(BigText())

                .background(Color.red)

                .edgesIgnoringSafeArea(.all)

        } else {

            return Text("UNKNOWN")

                .modifier(BigText())

                .background(Color.gray)

                .edgesIgnoringSafeArea(.all)

        }

    }

}



struct BeaconView_Previews: PreviewProvider {

    static var previews: some View {

        BeaconView()

    }

}
