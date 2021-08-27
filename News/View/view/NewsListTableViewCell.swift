//
//  NewsListTableViewCell.swift
//  News
//
//  Created by Naira Bassam on 26/08/2021.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    //MARK: - Outlet    
    @IBOutlet weak var viewNewsCell: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewNewsCell.design(9)
    }
    
     func configure(with viewModel: NewsViewModel) {
        newsTitle.text = viewModel.title
        newsSourceName.text = viewModel.sourceName
        //Image
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        }else if let url = viewModel.imageURL {
            //fetch
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
        
    }

}
