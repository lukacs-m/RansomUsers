//
//  ReachabilityService.swift
//  RandomUsers
//
//  Created by Martin Lukacs on 03/03/2022.
//

import Network
import Combine

public protocol NetworkReachability {
    var isNetworkAvailable: CurrentValueSubject<Bool, Never> {get}
}

public final class ReachabilityService: NetworkReachability {
    public var isNetworkAvailable: CurrentValueSubject<Bool, Never> = .init(false)
    
    private let monitor: NWPathMonitor
    private let backgroudQueue = DispatchQueue.global(qos: .background)
    
    public init() {
        monitor = NWPathMonitor()
        setUp()
    }
    
    init(with interFaceType: NWInterface.InterfaceType) {
        monitor = NWPathMonitor(requiredInterfaceType: interFaceType)
        setUp()
    }
    
    deinit {
        monitor.cancel()
    }
}

private extension ReachabilityService {
    func setUp() {
        
        monitor.pathUpdateHandler = { [weak self] path in
            switch path.status {
            case .satisfied:
                self?.isNetworkAvailable.send(true)
            case .unsatisfied, .requiresConnection:
                self?.isNetworkAvailable.send(false)
            @unknown default:
                self?.isNetworkAvailable.send(false)
            }
        }
        
        monitor.start(queue: backgroudQueue)
    }
}
