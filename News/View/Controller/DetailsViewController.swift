//
//  DetailsViewController.swift
//  News
//
//  Created by Naira Bassam on 26/08/2021.
//

import UIKit

class DetailsViewController: UIViewController {

    private var viewModel = [DetailsViewModel]()
    var selectedTitle = ""
    
    //MARK: - Outlet
    @IBOutlet weak var viewDetailsNews: UIView!
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsSourceName: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    
    //MARK: - Action
    @IBAction func buttonPressed(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        insideView.roundTopCorners()
        viewDetailsNews.roundTopCorners()
        
        NewsManager.shared.performRequest { [weak self]result in
            switch result {
            case .success(let articles):
                self?.viewModel = articles.compactMap({
                    DetailsViewModel(sourceName: $0.source.name,
                                     title: $0.title,
                                     imageURL: URL(string: $0.urlToImage ?? ""),
                                     description: $0.description ?? "There's no description for this article", url: $0.url ?? "")
                })
                for i in 0..<articles.count {
                    if articles[i].title == self!.selectedTitle {
                        DispatchQueue.main.async {
                            self!.configure(with: self!.viewModel[i])
                        }
                    }
                }
            case .failure(let error):
                self?.showMessage(withTitle: "Error", message: error.localizedDescription)
            }
        }
    }
    
    
    func configure(with viewModel: DetailsViewModel) {
        newsTitle.text = viewModel.title
        newsSourceName.text = viewModel.sourceName
        guard let description = viewModel.description else {
            return
        }
        newsDescription.text = description
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
    
    func showMessage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
