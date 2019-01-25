//
//  NotificationViewController.swift
//  XWCustomNotification
//
//  Created by bene on 2019/1/23.
//  Copyright © 2019 bene. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        self.titleLabel.text = notification.request.content.title
        self.playButton .setImage(UIImage.init(named: "icon_hang_up"), for: .normal)
        self.acceptButton.setImage(UIImage.init(named: "icon_answer"), for: .normal)
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "cancel_action" {
            print("取消按钮")
        } else if response.actionIdentifier == "ok_action" {
            print("接受按钮")
        }
    }

}
