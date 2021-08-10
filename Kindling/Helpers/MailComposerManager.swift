//
//  MailComposerManager.swift
//  Kindling
//
//  Created by Eduardo Bernal on 04/08/21.
//

import Foundation
import MessageUI

class MailComposerManager: NSObject {
    var canSendMail: Bool {
        MFMailComposeViewController.canSendMail()
    }
    
    func composeMail(viewController: UIViewController, recipients: [String]) {
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(recipients)
        viewController.present(composer, animated: true, completion: nil)
    }
}

extension MailComposerManager: MFMailComposeViewControllerDelegate {
    
}
