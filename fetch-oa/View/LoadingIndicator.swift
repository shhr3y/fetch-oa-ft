//
//  LoadingIndicator.swift
//  fetch-oa
//
//  Created by Shrey Gupta on 9/3/23.
//

import UIKit


/// This class adds a loading indicator to any view provided during initialisation.
class LoadingIndicator: UIView {
    // MARK: - Variables
    // reference to superview(in which the loading indicator is supposed to be added.)
    let superView: UIView
    
    // optional variable, helps to keep a reference to current loading indicator.
    var spinnerView: UIView?
    
    
    // MARK: - Init
    init(superView: UIView) {
        self.superView = superView
        
        super.init(frame: superView.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper Functions
    /// called to add loading indicator to superview and start animating.
    func startAnimation() {
        self.spinnerView = UIView.init(frame: superView.bounds)
        guard let spinnerView else { return }
        
        // declaring activityIndicator of style large with tint color as white.
        let activityIndicator = UIActivityIndicatorView.init(style: .large)
        activityIndicator.color = .white
        
        // adding background color to spinner view
        spinnerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        // alignment of activityIndicator in spinnerView
        activityIndicator.center = spinnerView.center
        
        // starting activityIndicator animation
        activityIndicator.startAnimating()
        
        
        // adding activityIndicator to spinnerView and spinnerView to superView.
        DispatchQueue.main.async { [weak self] in
            spinnerView.addSubview(activityIndicator)
            self?.superView.addSubview(spinnerView)
        }
    }
    
    
    /// called to stop and remove spinnerView animation
    func stopAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.spinnerView?.removeFromSuperview()
            self?.spinnerView = nil
        }
    }
}
