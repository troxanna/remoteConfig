//
//  ViewController.swift
//  remoteConfig
//
//  Created by Anastasia Nevodchikova on 22.06.2023.
//

import UIKit
import SnapKit
import FirebaseRemoteConfig

class ViewController: UIViewController {

    var remoteConfig = RemoteConfig.remoteConfig()
    var textLabelRC: String?
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.text = "Text from app"
        label.textColor = .black
        return label
    }()
    
    lazy private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Click me", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        remoteConfig.fetchAndActivate { (status, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let textLabel = self.remoteConfig["textLabel"].stringValue {
                    self.textLabelRC = textLabel
                }
            }
        }
    }
}

private extension ViewController {
    func setupConstraints() {
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(label)
        
        label.snp.makeConstraints({ make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        })
        
        button.snp.makeConstraints({ make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(label.snp.bottom).offset(40)
            make.width.equalTo(300)
        })
    }
    
    func setupSettings() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    @objc func buttonClicked() {
        label.text = textLabelRC
    }
}

