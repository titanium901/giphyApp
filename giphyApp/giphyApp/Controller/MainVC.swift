//
//  MainVC.swift
//  giphyApp
//
//  Created by Yury Popov on 09/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit
import SDWebImage

class MainVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var giphys = [Data]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
        
        loadGifs()

    }
    
    
    @IBAction func tapOnLogo(_ sender: UITapGestureRecognizer) {
        giphys.removeAll()
        searchBar.text = nil
        reloadSearchBar()
        loadGifs()
    }
    
    func loadGifs() {
        let gifRequest = GifReguest(searchURL: false, word: nil, limit: "50", endpoint: "trending")
        gifRequest.getGifs { [weak self] result in
            print(result)
            switch result {
            case .failure(let error):
                print(error)
            case .success(let gifs):
                self?.giphys = gifs
                
            }
        }
    }
    

}

//MARK: - UITableViewDelegate

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return giphys.count
        } else if section == 1 {
            return 1
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GifCell
            configure(cell, forItemAt: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                cell.spinner.stopAnimating()
            }
            return cell
        }
        
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = giphys.count - 1
        if indexPath.row == lastItem {
            let moreRequest = GifReguest(searchURL: true, word: RandomWord.share.random(), limit: "50", endpoint: "")
            moreRequest.getGifs { [weak self] result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let gifs):
                    print("Sucsess")
                    self?.giphys.append(contentsOf: gifs)
                }
            }
        }
    }
    
    func configure(_ cell: GifCell, forItemAt indexPath: IndexPath) {
        let gifUrl = giphys[indexPath.row].images.fixedHeightDownsampled.url
        cell.gifImage.sd_setImage(with: URL(string: gifUrl), completed: nil)
    }
}

//MARK: - UISearchBarDelegate

extension MainVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let word = searchBar.text else { return }
        
        let searchRequest = GifReguest(searchURL: true, word: word, limit: "1000", endpoint: "")
        searchRequest.getGifs { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let gifs):
                print("Sucsess")
                self?.giphys.removeAll()
                self?.giphys.insert(contentsOf: gifs, at: 0)
                
            }
        }
        
        reloadSearchBar()
    }
    
    func reloadSearchBar() {
        searchBar.resignFirstResponder()
        tableView.setContentOffset(.zero, animated: true)
        
    }
    
   
}





