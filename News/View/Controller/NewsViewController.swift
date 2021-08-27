//
//  ViewController.swift
//  News
//
//  Created by Naira Bassam on 25/08/2021.
//

import UIKit

class NewsViewController: UIViewController {
   
    private var viewModel = [NewsViewModel]()
    var titleCell = ""
    
    //MARK: - Outlet
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - View LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.rightBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.backgroundImage = UIImage()
        NewsManager.shared.performRequest { [weak self]result in
            switch result {
            case .success(let articles):
                self?.viewModel = articles.compactMap({
                    NewsViewModel(sourceName: $0.source.name,
                                  title: $0.title,
                                  imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.newsListTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

//MARK: - TableView DataSource Methods

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsListTableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! NewsListTableViewCell
        cell.configure(with: viewModel[indexPath.row])
        titleCell = cell.newsTitle.text!
        return cell
    }

}

//MARK: - TableView Delegate Methods

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: K.detailsIdentifier, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let distenationVC = segue.destination as! DetailsViewController
        if let indexPath = newsListTableView.indexPathForSelectedRow {
            distenationVC.selectedTitle = viewModel[indexPath.row].title
        }
    }
}

//MARK: - UISearchBarDelegate Methods

extension NewsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {return}
        NewsManager.shared.search(with: text) {[weak self]result in
            switch result {
            case .success(let articles):
                self?.viewModel = articles.compactMap({
                    NewsViewModel(sourceName: $0.source.name,
                                  title: $0.title,
                                  imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.newsListTableView.reloadData()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            NewsManager.shared.performRequest { [weak self]result in
                switch result {
                case .success(let articles):
                    self?.viewModel = articles.compactMap({
                        NewsViewModel(sourceName: $0.source.name,
                                      title: $0.title,
                                      imageURL: URL(string: $0.urlToImage ?? ""))
                    })
                    DispatchQueue.main.async {
                        self?.newsListTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}
