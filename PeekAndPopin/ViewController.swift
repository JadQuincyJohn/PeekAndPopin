//
//  ViewController.swift
//  PeekAndPopin
//
//  Created by Jad Abi-Abdallah on 30/01/2019.
//  Copyright © 2019 Jad Abi-Abdallah. All rights reserved.
//

import UIKit

struct Item {
    let title: String
    let image: UIImage
}

struct ViewModel {
    
    let items: [Item] = [Item(title: "Paris", image: UIImage(named: "1")!),
                         Item(title: "Budapest", image: UIImage(named: "2")!),
                         Item(title: "Berlin", image: UIImage(named: "3")!),
                         Item(title: "Copenhagen", image: UIImage(named: "4")!),
                         Item(title: "Amsterdam", image: UIImage(named: "5")!),
                         Item(title: "Lisbon", image: UIImage(named: "6")!),
                         Item(title: "Bratislava", image: UIImage(named: "7")!),
                         Item(title: "Zagreb", image: UIImage(named: "8")!),
                         Item(title: "Ljubjana", image: UIImage(named: "9")!)]
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 103
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
        
        navigationItem.title = "Brutalism"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! ItemCell
        cell.label.text = viewModel.items[indexPath.row].title
        cell.photoImageView.image = viewModel.items[indexPath.row].image
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        if let indexPath = tableView.indexPathForRow(at: location) {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let preview = storyboard.instantiateViewController(withIdentifier: String(describing: PreviewViewController.self)) as! PreviewViewController
            
            let item = viewModel.items[indexPath.row]

            preview.viewModel = PreviewViewControllerViewModel(item: item)
            preview.preferredContentSize = CGSize(width: 0.0, height: 300)
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            return preview
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.show(viewControllerToCommit, sender: nil)
    }
    
}

