//
//  ItemDetailImageCell.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/1/23.
//

import UIKit

fileprivate class Constants {
    static let cornerRadius: CGFloat = 12
}

/// UICollectionViewCell class for ItemDetailImageCell.
class ItemDetailImageCell: UICollectionViewCell {
    // MARK: - Variables
    // link to image. when set, should update UI for the cell.
    var imageLink: String? {
        didSet {
            guard let imageLink else { return }

            // checking if item image url is an valid link. if yes, updating itemImageView with image url.
            if let url = URL(string: imageLink) {
                self.itemImageView.load(url: url)
            }
        }
    }
    
    
    // MARK: - UI Elements
    /// itemImageView used for displaying item image.
    private let itemImageView: UIImageView = {
        let iv = UIImageView()
        
        // adding default background color to image. only visible when image is not loaded.
        iv.backgroundColor = .lightGray
        
        return iv
    } ()

    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // setting imageview height and width same to have squared image.
        itemImageView.setDimensions(height: self.frame.width, width: self.frame.width)
        
        // configure UI for cell
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    func configureView() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
        
        // added itemImageView and filled with bounds of superview.
        addSubview(itemImageView)
        itemImageView.fillSuperview()
    }
}
