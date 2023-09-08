//
//  ItemDetailIngredientsItemCell.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/2/23.
//

import UIKit

class ItemDetailIngredientsItemCell: UICollectionViewCell {
    // ingredient of type [String: String] (dictionary). when set, should update UI for the cell.
    var ingredient = [String: String]() {
        didSet {
            guard !ingredient.isEmpty else { return }
            
            // checking if first key exist. if yes, update ingredientNameLabel with key
            if let name = ingredient.keys.first {
                self.ingredientNameLabel.text = name
            }
            
            // checking if first value exist. if yes, update ingredientAmountLabel with value
            if let amount = ingredient.values.first {
                self.ingredientAmountLabel.text = amount
            }
        }
    }
    
    
    /// ingredientNameLabel used to showing ingredient name
    private let ingredientNameLabel: UILabel = {
        let label = UILabel()
        return label
    } ()
    
    /// ingredientAmountLabel used to showing ingredient measurement
    private let ingredientAmountLabel: UILabel = {
        let label = UILabel()
        return label
    } ()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configure UI
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        // creating a stackview for showing information. if any text is get larger, it will be managed by stackview(truncated).
        let stack = UIStackView(arrangedSubviews: [ingredientNameLabel, ingredientAmountLabel])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        
        // adding stack to main view with height of 42.
        addSubview(stack)
        stack.anchor(height: 42)
        stack.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
}
