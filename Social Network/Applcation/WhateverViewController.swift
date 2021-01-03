//
//  WhateverViewController.swift
//  Navigation
//
//  Created by Arthur Raff on 20.12.2020.
//

import UIKit

///Контроллер отвечающий за подсчет времени работы в фоновом режиме
class WhateverViewController: UIViewController {
    var resultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Начать отсчет", for: .normal)
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(didTapPlayPause(sender:)), for: .touchUpInside)
        button.toAutoLayout()
        
        return button
        
    }()
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    deinit {
        NotificationCenter.default.removeObserver(self)
      }
    
    func setupLayout() {
        view.addSubview(resultsLabel)
        view.addSubview(button)
        
        let constraints = [
            button.heightAnchor.constraint(equalToConstant: 40),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            
            
            resultsLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 24),
            resultsLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func resetCalculation() {
        previous = .one
        current = .one
        position = 1
    }

    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler:) {
          [unowned self] in
          self.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
    }
  
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskIdentifier.invalid
    }
    
    @objc func didTapPlayPause(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            resetCalculation()
            updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
            registerBackgroundTask()
        } else {
            updateTimer?.invalidate()
            updateTimer = nil
            if backgroundTask != .invalid {
            endBackgroundTask()
            }
        }
    }
  
    @objc func reinstateBackgroundTask() {
        if updateTimer != nil && (backgroundTask == .invalid) {
          registerBackgroundTask()
        }
    }
  
    @objc func calculateNextNumber() {
        let result = current.adding(previous)

        let bigNumber = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)
        if result.compare(bigNumber) == .orderedAscending {
            previous = current
            current = result
            position += 1
        }
        else {
          // This is just too much.... Let's start over.
          resetCalculation()
        }
      
        let resultsMessage = "Position \(position) = \(current)"
        
        switch UIApplication.shared.applicationState {
        case .active:
            resultsLabel.text = resultsMessage
        case .background:
            print("App is backgrounded. Next number = \(resultsMessage)")
            print("Background time remaining = " + "\(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            break
        @unknown default:
            fatalError()
        }
      }
}
