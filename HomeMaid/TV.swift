//
//  TV.swift
//  HomeMaid
//
//  Created by 田中 達也 on 2016/10/23.
//  Copyright © 2016年 Tatsuya Tanaka (tattn). All rights reserved.
//

import Foundation
import HomeKit

public struct TV {
    private let power: HMCharacteristic

    init(accessory: HMAccessory) {
        // 電源スイッチの取得
        power = accessory.services
            .filter  { $0.serviceType == HMServiceTypeSwitch }
            .flatMap { $0.characteristics }
            .filter  { $0.characteristicType == HMCharacteristicTypePowerState }
            .first ?? HMCharacteristic()
    }

    public func getPower(completion: @escaping (Bool) -> Void) {
        power.readValue { error in
            completion(self.power.value as? Bool ?? false)
        }
    }

    public func setPower(isOn: Bool, completion: ((Error?) -> Void)? = nil) {
        power.writeValue(isOn) { error in
            completion?(error)
        }
    }
}
