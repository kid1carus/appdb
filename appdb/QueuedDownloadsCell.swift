//
//  QueuedDownloadsCell.swift
//  appdb
//
//  Created by ned on 22/04/2019.
//  Copyright © 2019 ned. All rights reserved.
//

import UIKit
import Cartography
import AlamofireImage

class QueuedDownloadsCell: UICollectionViewCell {

    fileprivate var iconSize: CGFloat = (75~~65)
    fileprivate var margin: CGFloat = (15~~12)
    fileprivate var name: UILabel!
    fileprivate var icon: UIImageView!
    fileprivate var status: UILabel!
    
    func configure(with app: RequestedApp) {
        name.text = app.name
        status.text = app.status
        if app.type != .myAppstore {
            if let url = URL(string: app.image) {
                icon.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "placeholderIcon"), filter: Global.roundedFilter(from: iconSize),
                             imageTransition: .crossDissolve(0.2))
            }
        } else {
            icon.image = #imageLiteral(resourceName: "blank_icon")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    func setup() {
        theme_backgroundColor = Color.veryVeryLightGray
        contentView.theme_backgroundColor = Color.veryVeryLightGray
        
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1 / UIScreen.main.scale
        contentView.layer.theme_borderColor = Color.borderCgColor
        layer.backgroundColor = UIColor.clear.cgColor
        
        // Name
        name = UILabel()
        name.theme_textColor = Color.title
        name.font = .systemFont(ofSize: 18.5~~16.5)
        name.numberOfLines = 1
        name.makeDynamicFont()
        
        // Icon
        icon = UIImageView()
        icon.layer.borderWidth = 1 / UIScreen.main.scale
        icon.layer.theme_borderColor = Color.borderCgColor
        icon.contentMode = .scaleToFill
        icon.layer.cornerRadius = Global.cornerRadius(from: iconSize)
        
        // Status
        status = UILabel()
        status.theme_textColor = Color.darkGray
        status.font = .systemFont(ofSize: 14~~13)
        status.numberOfLines = 2
        status.makeDynamicFont()
        
        contentView.addSubview(name)
        contentView.addSubview(icon)
        contentView.addSubview(status)
        
        constrain(name, status, icon) { name, status, icon in
            icon.width ~== iconSize
            icon.height ~== icon.width
            icon.left ~== icon.superview!.left ~+ margin
            icon.centerY ~== icon.superview!.centerY
            
            (name.left ~== icon.right ~+ (15~~12)) ~ Global.notMaxPriority
            name.right ~== name.superview!.right ~- margin
            name.top ~== icon.top ~+ 5
            
            status.left ~== name.left
            status.top ~== name.bottom ~+ (2~~0)
            status.right ~<= status.superview!.right ~- margin
            
        }
    }
}
