//
//  Reachability.swift
//  AUWeatherApp
//
//  Created by Anand Upadhyay on 13/02/23.
//

import Foundation
import Network



class Reachability {

    enum StatusFlag {
        case unknow
        case noConnection
        case connectedViaWiFi
        case connectedViaCellular
    }

    static let connectionStatusHasChangedNotification = NSNotification.Name("Reachability.connectionStatusHasChangedNotification")
    
    static let shared = Reachability()

    private var monitorForWifi: NWPathMonitor?
    private var monitorForCellular: NWPathMonitor?
    private var wifiStatus: NWPath.Status = .requiresConnection
    private var cellularStatus: NWPath.Status = .requiresConnection
    private var ignoreInitialWiFiStatusUpdate: Bool = true
    private var ignoreInitialCelluluarStatusUpdate: Bool = true
    private var isReachableOnCellular: Bool { cellularStatus == .satisfied }
    private var isReachableOnWiFi: Bool { wifiStatus == .satisfied }
    var status: StatusFlag = .unknow {
        didSet {
            guard status != oldValue else { return }
            DispatchQueue.main.async { [weak self] in
                NotificationCenter.default.post(name: Self.connectionStatusHasChangedNotification,
                                                object: self?.status)
            }
        }
    }

    func startMonitoring() {
        monitorForWifi = NWPathMonitor(requiredInterfaceType: .wifi)
        monitorForWifi?.pathUpdateHandler = { [weak self] path in
            self?.wifiStatus = path.status
            self?.ignoreInitialWiFiStatusUpdate = false
            self?.updateStatus()
        }
        monitorForCellular = NWPathMonitor(requiredInterfaceType: .cellular)
        monitorForCellular?.pathUpdateHandler = { [weak self] path in
            self?.cellularStatus = path.status
            self?.ignoreInitialCelluluarStatusUpdate = false
            self?.updateStatus()
        }
        let queue = DispatchQueue.global(qos: .background)
        monitorForCellular?.start(queue: queue)
        monitorForWifi?.start(queue: queue)
    }

    func stopMonitoring() {
        monitorForWifi?.cancel()
        monitorForWifi = nil
        monitorForCellular?.cancel()
        monitorForCellular = nil
        wifiStatus = .requiresConnection
        cellularStatus = .requiresConnection
        status = .unknow
        ignoreInitialWiFiStatusUpdate = true
        ignoreInitialCelluluarStatusUpdate = true
    }

    private func updateStatus() {
        if ignoreInitialWiFiStatusUpdate || ignoreInitialCelluluarStatusUpdate {
            return
        }
        if !(isReachableOnCellular && isReachableOnWiFi) {
            if isReachableOnCellular && !isReachableOnWiFi {
                status = .connectedViaCellular
            } else if isReachableOnWiFi && !isReachableOnCellular {
                status = .connectedViaWiFi
            } else {
                status = .noConnection
            }
        } else {
            status = .connectedViaWiFi
        }
    }

    static func isConnectedToNetwork() -> Bool {
        return shared.isReachableOnCellular || shared.isReachableOnWiFi
    }
}
