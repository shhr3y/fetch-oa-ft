//
//  ViewController.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

fileprivate class Constants {
    static let interItemSpacing: CGFloat = 4
    static let lineSpacing: CGFloat = 8
    
    static let title = "Desserts"
}

class MainController: UIViewController {
    // MARK: - UI
    let collectionView: UICollectionView
    
    
    /// loading indicator. used when waiting for response from API callbacks.
    lazy var spinner = LoadingIndicator(superView: self.view)
    
    
    // MARK: - Variables
    
    /// list of MenuItem. used as datasource for collectionView. when set, collectionView is reloaded
    var menuItems = [MenuItem]() {
        didSet {
            // switching to main thread because we need to do an UI update.
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    // MARK: - Init
    init() {
        // creating custom layout for our collectionView.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.lineSpacing
        layout.minimumInteritemSpacing = Constants.interItemSpacing
        
        // initialising our collectionView with the custom layout created.
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(nibName: nil, bundle: nil)
        
        // setting title to Desserts for preview in navigation bar
        title = Constants.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // allows large titles on all child controllers of navigation controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // added collectionView to main view and filled with super view.
        self.view.addSubview(collectionView)
        self.collectionView.fillSuperview()
        
        
        // conforming to delegate and datasource for collectionView
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // registering MenuItemCell to collectionvView for reuse.
        self.collectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: MenuItemCell.reuseIdentifier)
        
        
        // fetching all items for dessert category.
        self.fetchMenuItems()
    }
    
    
    // MARK: - Helper Functions
    func fetchMenuItems() {
        // start loading indicator animation
        spinner.startAnimation()
        
        // fetching menu items for dessert from singleton variable NetworkService.
        NetworkService.shared.fetchMenuItems(byCategory: .dessert) { result in
            // stopping loading indicator animation once received completion
            self.spinner.stopAnimation()
            
            // checking result status
            switch result {
            // if success: sort items and update menu items.
            case .success(var menuItems):
                // sorting menu items based on name in ascending order
                menuItems.sort(by: {$0.name < $1.name})
                
                // updating menuItems (class variable)
                self.menuItems = menuItems
            
            // if failure: just print error and return
            case .failure(let error):
                print("Error: \(error)")
                return
            }
        }
    }
}


// MARK: - Datasource UICollectionViewDataSource
extension MainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem - 8)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCell.reuseIdentifier, for: indexPath) as? MenuItemCell else {
            return UICollectionViewCell()
        }
        // setting MenuItem in MenuItemCell for respective indexpath
        cell.item = self.menuItems[indexPath.row]
        return cell
    }
}


// MARK: - Delegate UICollectionViewDelegate
extension MainController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // itemId for selected menu item.
        let selectedItemId = self.menuItems[indexPath.row].id
        
        // start loading indicator animation
        spinner.startAnimation()
        
        // fetching item for selected item id from singleton variable NetworkService.
        NetworkService.shared.fetchItemDetails(withItemId: selectedItemId) {[weak self] result in
            // stopping loading indicator animation once received completion
            self?.spinner.stopAnimation()
            
            // checking result status
            switch result {
            // if success: push to ItemDetailViewController into current navigation stack with item.
            case .success(let item):
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(ItemDetailViewController(withItem: item), animated: true)
                }
                
            // if failure: just print error and return
            case .failure(let error):
                print("Error: \(error)")
                return
            }
        }
    }
}
