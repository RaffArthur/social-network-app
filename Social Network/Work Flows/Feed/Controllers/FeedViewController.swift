//
//  FeedViewController.swift
//  Navigation
//
//

import UIKit

@available(iOS 13.0, *)
final class FeedViewController: UIViewController {
    
    // MARK: - Properties
    private var buttonsStackView: UIStackView = {
        var buttonOne = UIButton()
        buttonOne.heightAnchor.constraint(equalToConstant: 56).isActive = true
        buttonOne.setTitle("Post Button One".uppercased(), for: buttonOne.state)
        buttonOne.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        buttonOne.backgroundColor = UIColor(named: "color_set")
        buttonOne.layer.cornerRadius = 12
        buttonOne.layer.borderWidth = 3
        buttonOne.layer.borderColor = UIColor.white.cgColor
        buttonOne.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)

        var buttonTwo = UIButton()
        buttonTwo.heightAnchor.constraint(equalToConstant: 56).isActive = true
        buttonTwo.setTitle("Post Button Two".uppercased(), for: buttonTwo.state)
        buttonTwo.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .black)
        buttonTwo.backgroundColor = UIColor(named: "color_set")
        buttonTwo.layer.cornerRadius = 12
        buttonTwo.layer.borderWidth = 3
        buttonTwo.layer.borderColor = UIColor.white.cgColor
        buttonTwo.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        
        var buttonStackView = UIStackView()
        buttonStackView.toAutoLayout()
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .fill
        buttonStackView.spacing = 10
        buttonStackView.addArrangedSubview(buttonOne)
        buttonStackView.addArrangedSubview(buttonTwo)
        buttonStackView.contentHuggingPriority(for: .vertical)
        buttonStackView.contentCompressionResistancePriority(for: .vertical)
        buttonStackView.distribution = .fill
        
        return buttonStackView
    }()
    
    // MARK: - View Funcs
    private func setupLayout() {
        let constraints = [
            buttonsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.96),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(buttonsStackView)
                
        setupLayout()
    }
    
    // MARK: - @objc Actions
    @objc func tappedButton(sender: UIButton!) {
        self.navigationController?.pushViewController(InfoViewController(), animated: true)
    }
}
