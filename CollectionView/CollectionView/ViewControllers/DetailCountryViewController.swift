//
//  DetailCountryViewController.swift
//  CollectionView
//
//  Created by Eric Widjaja on 9/26/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class DetailCountryViewController: UIViewController {
    
    var detailCountry: CountryList!
    
    @IBOutlet weak var detailName: UILabel!
    
    @IBOutlet weak var detailCapital: UILabel!
    
    @IBOutlet weak var detailPopulation: UILabel!
    
    @IBOutlet weak var detailFlag: UIImageView!
    
    @IBOutlet weak var detailCurrency: UILabel!
    
    
    func loadDetails(){
        detailName.text = detailCountry.name
        detailCapital.text = "Capital: \(String(describing: detailCountry.capital))"
        detailPopulation.text = "Population: \(detailCountry.population)"
        ImageAPIClient.manager.loadImage(from: detailCountry.imageURL) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let image):
                    self.detailFlag.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
    }
}
