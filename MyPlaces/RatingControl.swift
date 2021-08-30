//
//  RatingControl.swift
//  MyPlaces
//
//  Created by кирилл ларионов on 14.08.2021.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    var rating = 0{
        didSet{
            updatebuttonSelectionState()
        }
    }
    
    
    private var ratingButtons = [UIButton]()
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
        didSet{
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5{
        didSet{
            setupButtons()
        }
    }
    
   

   //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    //MARK: Button Action
    
    @objc func ratingButtonTapped(button: UIButton){
        
        guard let index = ratingButtons.firstIndex(of: button) else { return }
        
        // Calculate the rating of the selected button
        let selectedRating = index + 1
        
        if selectedRating == rating{
            rating = 0
        }else{
            rating = selectedRating
        }
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Private Methods
    
    private func setupButtons(){
        
        for button in ratingButtons{
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        // Load button image
        let bundle = Bundle(for: type(of: self))
        let filledHand = UIImage(named: "hand1",
                                 in: bundle,
                                 compatibleWith: self.traitCollection)
        let emptyHand = UIImage(named: "hand",
                                in: bundle,
                                compatibleWith: self.traitCollection)
        
        
        
        for _ in 0..<starCount {
            let button = UIButton()
            
            //set the button image
            button.setImage(emptyHand, for: .normal)
            button.setImage(filledHand, for: .selected)
            
            // Add constraintns
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            //Add the new button on the rating button array
            ratingButtons.append(button)
        }
        updatebuttonSelectionState()
    }
    
    private func updatebuttonSelectionState(){
        for(index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
        }
    }
}

