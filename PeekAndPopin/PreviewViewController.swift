//
//  PreviewViewController.swift
//  PeekAndPopin
//
//  Created by Jad Abi-Abdallah on 30/01/2019.
//  Copyright © 2019 Jad Abi-Abdallah. All rights reserved.
//

import UIKit

struct PreviewViewControllerViewModel {
    let item: Item
    
    var image: UIImage {
        return item.image
    }
    
    var title: String {
        return item.title
    }
}

class PreviewViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImageView: UIImageView!

    var viewModel: PreviewViewControllerViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        titleLabel.text = viewModel.title
        previewImageView.image = viewModel.image
    }

    override var previewActionItems: [UIPreviewActionItem] {

        let facebook = UIPreviewAction(title: "Facebook", style: .default) { (action, viewController) in
            print("Facebook")
        }
        
        let insta = UIPreviewAction(title: "Instagram", style: .default) { (action, viewController) in
            print("Instagram")
        }
        
        let share = UIPreviewActionGroup(title: "Share photo!", style: .default, actions: [facebook, insta])
        
        let care = UIPreviewAction(title: "Care", style: .default) { (action, viewController) in
            print("Care")
        }
        
        return [share, care]
        
    }
}
