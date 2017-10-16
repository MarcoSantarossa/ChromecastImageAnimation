//
//  ViewController.swift
//  ChromecastImageAnimation
//
//  Created by Marco Santarossa on 10/10/2017.
//  Copyright © 2017 Marco Santarossa. All rights reserved.
//

import UIKit

enum CastState {
    case connected
    case disconnected
}

class ViewController: UIViewController {
    
    @IBOutlet private weak var chromecastImageView: UIImageView!
    @IBOutlet private weak var connectButton: UIButton!
    
    private var castState = CastState.disconnected
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageViewAnimation()
    }
    
    private func setupImageViewAnimation() {
        chromecastImageView.animationImages = [#imageLiteral(resourceName: "cast_0"), #imageLiteral(resourceName: "cast_1"), #imageLiteral(resourceName: "cast_2")]
        chromecastImageView.animationDuration = 1
    }

    @IBAction private func onConnectButton(_ sender: Any) {
        switch castState {
        case .connected:
            disconnect()
        case .disconnected:
            connect()
        }
    }
    
    private func connect() {
        // Disables the button to avoid user interaction when the animation is running
        connectButton.isEnabled = false
        
        chromecastImageView.startAnimating()
        
        // Simulates a connection delay of 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.chromecastImageView.stopAnimating()
            
            // Enables the button to allow user interaction
            self.connectButton.isEnabled = true

            // Updates UI
            self.toggleCastState()
        }
    }
    
    private func disconnect() {
        // Updates UI
        toggleCastState()
    }
    
    private func toggleCastState() {
        // Updates current Chromecast state
        castState = castState == .connected ? .disconnected : .connected
        
        // Updates button title
        let buttonTitle = castState == .connected ? "Disconnect" : "Connect"
        connectButton.setTitle(buttonTitle, for: .normal)
        
        // Updates `UIImageView` default image
        let image = castState == .connected ? #imageLiteral(resourceName: "cast_connected") : #imageLiteral(resourceName: "cast_disconnected")
        chromecastImageView.image = image
    }
}
