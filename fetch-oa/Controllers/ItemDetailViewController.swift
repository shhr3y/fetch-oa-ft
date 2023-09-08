//
//  ItemDetailViewController.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

enum ItemDetailViewStructure: Int, CaseIterable {
    case image
    case ingredients
    case instructions
}

fileprivate class Constants {
    static let estimatedWidth: CGFloat = 100
    static let edgeInsets: CGFloat = 12
    static let interGroupSpacing: CGFloat = 12
}


class ItemDetailViewController: UICollectionViewController {
    // MARK: - Variables
    // init using MenuItemDetail (item) which needs to be shown.
    let item: MenuItemDetail
    
    
    // MARK: - Init
    init(withItem item: MenuItemDetail) {
        self.item = item
        
        // using compostional layout for auto resizing cells
        // giving estimated size allowing collectionView to alocate size
        let size = NSCollectionLayoutSize(
            widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
            heightDimension: NSCollectionLayoutDimension.estimated(Constants.estimatedWidth)
        )
        
        
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
        
        // create NSCollectionLayoutSection using group created above.
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: Constants.edgeInsets,
                                                        leading: Constants.edgeInsets,
                                                        bottom: Constants.edgeInsets,
                                                        trailing: Constants.edgeInsets)
        
        section.interGroupSpacing = Constants.interGroupSpacing
        
        // initialise compositional layout using section created above
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        // initialise collectionView using compositional layout created.
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title with meal name, allowing navigation bar title using large title.
        title = item.mealName
        
        // conforming to delegate and datasource for UICollectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // registering ItemDetailImageCell, ItemDetailIngredientsCell, ItemDetailsRecipeCell to collectionvView for reuse.
        collectionView.register(ItemDetailImageCell.self, forCellWithReuseIdentifier: ItemDetailImageCell.reuseIdentifier)
        collectionView.register(ItemDetailIngredientsCell.self, forCellWithReuseIdentifier: ItemDetailIngredientsCell.reuseIdentifier)
        collectionView.register(ItemDetailsRecipeCell.self, forCellWithReuseIdentifier: ItemDetailsRecipeCell.reuseIdentifier)
    }
    
    
    // MARK: - Helper Functions
}


// MARK: - Datasource UICollectionViewDataSource
extension ItemDetailViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // showing cells based on ItemDetailViewStructure's items
        return ItemDetailViewStructure.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // getting type based on indexpath
        let type = ItemDetailViewStructure(rawValue: indexPath.section)!
        
        switch type {
        case .image:
            // dequeing ItemDetailImageCell from indexPath
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailImageCell.reuseIdentifier, for: indexPath) as? ItemDetailImageCell {
                // updating imagelink for item image
                cell.imageLink = item.thumbnailURLString
                return cell
            }
        case .ingredients:
            // dequeing ItemDetailIngredientsCell from indexPath
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailIngredientsCell.reuseIdentifier, for: indexPath) as? ItemDetailIngredientsCell {
                // updating ingredients for item
                cell.ingredientsMap = item.ingredients 
                return cell
            }
        case .instructions:
            // dequeing ItemDetailsRecipeCell from indexPath
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemDetailsRecipeCell.reuseIdentifier, for: indexPath) as? ItemDetailsRecipeCell {
                // updating recipe for item
                cell.recipe = item.instructions
                return cell
            }
        }
        
        // returning base UICollectionViewCell when no case is met. ideally, this would never be the case.
        return UICollectionViewCell()
    }
}
