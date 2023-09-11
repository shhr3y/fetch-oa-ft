//
//  MenuItemCellView.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

fileprivate class Constants {
    static let cornerRadius: CGFloat = 24
    static let textPadding: CGFloat = 12
}

/// UICollectionViewCell class for MenuItemCell.
class MenuItemCell: UICollectionViewCell {
    // MARK: - Variables
    // object of type MenuItem. when set, should update UI for the cell.
    var item: MenuItem? {
        didSet {
            guard let item else { return }

            // updating itemNameLabel with item name
            self.itemNameLabel.text = item.name
            
            // checking if item image url is an valid link. if yes, updating itemImageView with image url.
            if let url = URL(string: item.thumbnail) {
                self.itemImageView.load(url: url)
            }
        }
    }
    
    
    // MARK: - UI Elements
    /// itemNameLabel used as label for item name.
    private let itemNameLabel: UILabel = {
        let label = UILabel()
        
        // allowing only upto two lines of item name.
        label.numberOfLines = 2
        
        // setting foregroundColor to white because of black gradient background view.
        label.textColor = .white
        return label
    } ()
    
    
    /// itemImageView used for displaying item thumbnail image.
    private let itemImageView: UIImageView = {
        let iv = UIImageView()
        
        // adding default background color to image. only visible when image is not loaded.
        iv.backgroundColor = .lightGray
        
        return iv
    } ()
    
    
    /// gradientView is used for shadow effect on item cells for showing item names with contrast.
    private lazy var gradientView: UIView = {
        let view = UIView()
        
        // creating a CAGradientLayer with clear and black colors as sub layer for main view.
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        
        // adding gradient sub layer at the bottom of main view.
        view.layer.insertSublayer(gradient, at: 0)
        
        return view
    } ()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // updating gradientView's layer's bounds when subview are layed out.
        if let gradient = gradientView.layer.sublayers?[0] as? CAGradientLayer {
            gradient.frame = gradientView.bounds
        }
    }
    
    // MARK: - Helper Functions
    func configureView() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        
        // adding itemImageView to root view. it is stretched to fill super view.
        addSubview(itemImageView)
        itemImageView.fillSuperview()
        
        
        // added gradientView after itemImageView to have a gradient effect of black color
        addSubview(gradientView)
        gradientView.anchor(bottom: bottomAnchor, width: frame.width, height: frame.width/2)
        
        // added itemNameLabel after gradientView (on top of all views).
        gradientView.addSubview(itemNameLabel)
        itemNameLabel.anchor(left: gradientView.leftAnchor,
                             bottom: gradientView.bottomAnchor,
                             right: gradientView.rightAnchor,
                             paddingLeft: Constants.textPadding,
                             paddingBottom: Constants.textPadding,
                             paddingRight: Constants.textPadding)
    }
}
