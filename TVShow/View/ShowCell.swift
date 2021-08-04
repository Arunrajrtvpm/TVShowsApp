//
//  ShowCell.swift
//  TVShow
//
//  Created by Arunraj on 04/08/21.
//

import Foundation

import UIKit

class ShowViewCell: UICollectionViewCell {
    
    
    var showImage: UIImageView!
    var showName:UILabel!
    private let itemsPerRow: CGFloat = 3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpCellView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func  setUpCellView() {
        
        self.contentView.backgroundColor = .black
        
        
        showName = {
            let field = UILabel(frame: .zero)
            field.translatesAutoresizingMaskIntoConstraints = false
            field.font = UIFont.systemFont(ofSize: 20.0)
            field.textColor = .white
            return field
        }()
        
        showImage = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()
        
        
        
        let mainStack: UIStackView = {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .vertical
            stack.spacing = 10
            stack.alignment = .center
            stack.distribution = .fillProportionally
            return stack
        }()
        
        self.contentView.addSubview(mainStack)
        
        mainStack.addArrangedSubview(showImage)
        mainStack.addArrangedSubview(showName)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 1),
            mainStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -1),
            mainStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 1),
            mainStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -1),
            
        ])
        
        NSLayoutConstraint.activate([
            showName.heightAnchor.constraint(equalToConstant: 30)

        ])
    }
    
}
