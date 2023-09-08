//
//  ItemDetailsRecipeCell.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

class ItemDetailsRecipeCell: UICollectionViewCell {
    // MARK: - Variables
    
    /// recipe of type string. this variable contains all text for the recipe. when set, update the UI.
    var recipe: String? {
        didSet {
            guard let recipe else { return }
            self.recipeLabel.text = recipe
        }
    }
    
    // MARK: - UI Elements
    private let recipeLabel: UILabel = {
        let label = UILabel()
        // setting numberOfLines to 0, allowing UILabel to expand as needed based on content.
        label.numberOfLines = 0
        return label
    } ()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configure UI
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    func configureView() {
        self.clipsToBounds = true
        
        // adding recipeLabel to main view.
        addSubview(recipeLabel)
        recipeLabel.fillSuperview(padding: .init(top: 12, left: 0, bottom: 12, right: 0))
    }
}
