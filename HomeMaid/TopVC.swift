//
//  TopVC.swift
//  HomeMaid
//
//  Created by 田中 達也 on 2016/10/23.
//  Copyright © 2016年 Tatsuya Tanaka (tattn). All rights reserved.
//

import UIKit
import HomeKit

final class TopVC: UIViewController {

    @IBOutlet private weak var tvSwitch: UISwitch!
    
    private let homeManager = HMHomeManager()

    fileprivate var tv: TV?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeManager.delegate = self
    }

    @IBAction private func onTvSwitchChanged(_ sender: UISwitch) {
        tv?.setPower(isOn: tvSwitch.isOn)
    }

}

extension TopVC: HMHomeManagerDelegate {
    func homeManagerDidUpdateHomes(_ manager: HMHomeManager) {
        let home = manager.primaryHome
        
        if let accessory = home?.accessories[1] {
            tv = TV(accessory: accessory)
        }
    }
}
