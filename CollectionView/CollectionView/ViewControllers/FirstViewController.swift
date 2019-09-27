//
//  FirstViewController.swift
//  CollectionView
//
//  Created by Eric Widjaja on 9/26/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var countries = [CountryList]() {
        didSet {
            countryCollectionView.reloadData()
        }
    }
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    var countrySearchString: String? {
        didSet {
            loadSearch(str: countrySearchString ?? "United")
        }
    }
    
    //MARK:Private Methods
    private func loadSearch(str: String){
        CountryListAPIManager.manager.getCountry(searchWord: str) {
            (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.countries = data
                }
            }
        }
    }

    override func viewDidLoad() {
        loadSearch(str: "United")
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        countrySearchBar.delegate = self
        super.viewDidLoad()
    }
}

extension FirstViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let country = countries[indexPath.row]
        guard let cell = countryCollectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CustomCountryCell else {return UICollectionViewCell() }
        cell.nameLabel.text = country.name
        cell.capitalLabel.text = "Capital: \(country.capital)"
        cell.populationLabel.text = "Population: \(country.population)"
        ImageAPIClient.manager.loadImage(from: country.imageURL) {
            (result) in DispatchQueue.main.async {
            switch result {
            case .success(let flag):
                cell.flagView.image = flag
            case .failure(let error):
                print(error)
                }
            }
        }.self
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailCountryViewController else {return}
        let cell = sender as! CustomCountryCell
        let indexPath = countryCollectionView.indexPath(for: cell)!
        destinationVC.detailCountry = countries[indexPath.row]
    }
}
extension FirstViewController: UISearchBarDelegate {
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           var searchTerm = searchBar.text ?? ""
           searchTerm = searchTerm.lowercased().replacingOccurrences(of: " ", with: "")
           loadSearch(str: searchTerm)
           print(searchTerm)
       }
}
