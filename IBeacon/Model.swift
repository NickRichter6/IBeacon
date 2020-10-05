//
//  Model.swift
//  IBeacon
//
//  Created by Nick Ivanov on 28.09.2020.
//

import CoreLocation

public struct Beacon {
    
    public var uuid: UUID
    public var minor: NSNumber
    public var major: NSNumber
    
    public init(uuid: UUID, minor: NSNumber, major: NSNumber) {
        self.uuid = uuid
        self.minor = minor
        self.major = major
    }
}

