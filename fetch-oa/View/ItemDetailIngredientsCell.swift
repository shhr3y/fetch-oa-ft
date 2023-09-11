//
//  ItemDetailIngredientsCell.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

fileprivate class Constants {
    static let ingredientItemCellHeight: CGFloat = 42
    static let interCellSpacing: CGFloat = 0
    static let cornerRadius: CGFloat = 12
    
    static let cellPrimaryColor: UIColor = .lightGray.withAlphaComponent(0.15)
    static let cellSecondaryColor: UIColor = .lightGray.withAlphaComponent(0.3)
}

class ItemDetailIngredientsCell: UICollectionViewCell {
    // MARK: - Variables
    let collectionView: UICollectionView
    
    
    /// map which contains all ingredients with its measurements as values. when set, collectionview is reloaded.
    var ingredientsMap = [String: Any]() {
        didSet {
            // reloading collectionView when datasource is updated.
            self.collectionView.reloadData()
            
            // updating height of collectionView based on number of items. (this helps superview to autosize its cells)
            self.collectionView.setDimensions(height: Constants.ingredientItemCellHeight * CGFloat(ingredientsMap.count), width: frame.width)
        }
    }
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = Constants.interCellSpacing
        layout.estimatedItemSize = CGSize(width: frame.width, height: Constants.ingredientItemCellHeight)
        
        // initialised collectionView with custom layout created above.
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        // conforming to UICollectionViewDataSource for collectionView
        collectionView.dataSource = self
        
        // registering ItemDetailIngredientItemCell to collectionView for reuse.
        collectionView.register(ItemDetailIngredientsItemCell.self, forCellWithReuseIdentifier: ItemDetailIngredientsItemCell.reuseIdentifier)
        
        
        // configure UI
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    func configureView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = Constants.cornerRadius
        
        
        // adding collectionView to main view and resizing it with superview's bounds.
        self.addSubview(collectionView)
        collectionView.fillSuperview()
    }
}

// MARK: - DataSource UITableViewDataSource
extension ItemDetailIngredientsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ingredientsMap.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailIngredientsItemCell.reuseIdentifier, for: indexPath) as?  ItemDetailIngredientsItemCell else { return UICollectionViewCell() }
        let idx = indexPath.row
        
        // getting key based on index.
        let key = String(Array(self.ingredientsMap.keys)[idx])
        
        // assigning key, value to cell.ingredient for specific cell.
        cell.ingredient = [key: self.ingredientsMap[key] as? String ?? ""]
        
        // updating backgroundColor based on index. if even primary color else secondary color
        cell.backgroundColor = idx%2 == 0 ? Constants.cellPrimaryColor : Constants.cellSecondaryColor
           
        return cell
    }
}

