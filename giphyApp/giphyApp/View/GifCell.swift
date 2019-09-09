//
//  GifCell.swift
//  giphyApp
//
//  Created by Yury Popov on 09/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

class GifCell: UITableViewCell {
    
    @IBOutlet weak var gifImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
