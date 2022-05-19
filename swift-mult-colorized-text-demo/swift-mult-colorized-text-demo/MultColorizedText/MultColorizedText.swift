//
//  MultColorizedText.swift
//  swift-mult-colorized-text-demo
//
//  Created by Paolo Prodossimo Lopes on 19/05/22.
//

import UIKit

struct MultColorizedText {
    
    //MARK: - Properties
    
    static let shared: Self = .init()
    
    //MARK: - Constructor
    
    private init() { /*SINGLETON*/ }
    
    //MARK: - Methods
    
    func modify(with configuration: Config) -> NSAttributedString {
        
        let basePhrase = configuration.complete
        let mutableStringRef = NSMutableAttributedString(string: basePhrase)
        
        guard validIfAllCharacterContainsInBase(configuration) else { return mutableStringRef }
        
        configuration.modifiers.forEach { modifier in
            let range = (basePhrase as NSString).range(of: modifier.text)
            mutableStringRef.addAttributes(modifier.style, range: range)
        }
    
        return mutableStringRef
    }
    
    private func validIfAllCharacterContainsInBase(_ configuration: Config) -> Bool {
        var allRules: [Bool] = []
        
        configuration.modifiers.forEach {
            allRules.append(configuration.complete.contains($0.text))
        }
        
        return (allRules.contains(false) == false)
    }
}


//MARK: - Config Model
extension MultColorizedText {
    struct Config {
        let complete: String
        let modifiers: [Modifiers]
    }
}

//MARK: - Modifiers Model
extension MultColorizedText {
    struct Modifiers {
        
        let text: String
        let style: [NSAttributedString.Key : Any]
        
        init(text: String, style: [NSAttributedString.Key : Any]) {
            self.text = text
            self.style = style
        }
        
        init(text: String, styles arrayOfStyles: [Self.StyleModifiers]) {
            let arrayOfDict = arrayOfStyles.map { $0.modifier }
            let tupleArray: [(NSAttributedString.Key, Any)] = arrayOfDict.flatMap { $0 }
            let dictonary = Dictionary(tupleArray, uniquingKeysWith: { (first, last) in last })
            self.init(text: text, style: dictonary)
        }
    }
}

//MARK: - StyleModifiers Enum
extension MultColorizedText.Modifiers {
    enum StyleModifiers {
        
        case font(size: CGFloat, weight: UIFont.Weight = .regular)
        case textColor(color: UIColor)
        case underline(style: NSUnderlineStyle, color: UIColor)
        
        var modifier: [NSAttributedString.Key : Any] {
            switch self {
            case .font(let size, let weight):
                return [.font: UIFont.systemFont(ofSize: size, weight: weight)]
                
            case.textColor(let color):
                return [.foregroundColor: color]
                
            case .underline(let style, let color):
                return [.underlineStyle: style.rawValue, .underlineColor: color]
            }
        }
    }
}
