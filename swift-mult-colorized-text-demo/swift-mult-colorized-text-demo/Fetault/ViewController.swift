//
//  ViewController.swift
//  swift-mult-colorized-text-demo
//
//  Created by Paolo Prodossimo Lopes on 19/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var customLabel: UILabel = {
        let label = UILabel()
        label.text = "some"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(customLabel)
        NSLayoutConstraint.activate([
            customLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
//        customizeLabel()
        customizeLabel2()
    }

    private func customizeLabel() {
        let complete = "Meu nome é Paolo"
        let modifier: [MultColorizedText.Modifiers] = [
            .init(text: "Meu", style: [:]),
            .init(text: "nome", style: [.foregroundColor : UIColor.blue]),
            .init(text: "Paolo", style: [.font: UIFont.boldSystemFont(ofSize: 34)]),
        ]
        let config = MultColorizedText.Config(complete: complete, modifiers: modifier)
        let attributed = MultColorizedText.shared.modify(with: config)
        customLabel.attributedText = attributed
    }
    
    private func customizeLabel2() {
        let complete = "Meu nome é Paolo"
        let modifier: [MultColorizedText.Modifiers] = [
            .init(text: "Meu", styles: [.font(size: 15), .textColor(color: .green)]),
            .init(text: "nome", styles: [.underline(style: .single, color: .brown)]),
            .init(text: "Paolo", styles: [.font(size: 32, weight: .bold)]),
        ]
        let config = MultColorizedText.Config(complete: complete, modifiers: modifier)
        let attributed = MultColorizedText.shared.modify(with: config)
        customLabel.attributedText = attributed
    }
}

