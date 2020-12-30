//
//  ConnectivityChecker.swift
//  ReleaseDate
//
//  Created by Pete Connor on 7/11/20.
//  Copyright © 2020 Pete Connor. All rights reserved.
//

import Foundation
import Network
import SwiftUI
 
class ConnectivityChecker: ObservableObject {
    
    @Published var disconnected = false
    
    init() {
        monitorNetwork()
    }
    
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    print("connected")
                    self.disconnected = false
                }
            } else {
                DispatchQueue.main.async {
                    print("disconnected")
                    self.disconnected = true
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
}
