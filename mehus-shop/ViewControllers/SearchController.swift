//
//  SearchController.swift
//  mehus-shop
//
//  Created by Ashiq Uz Zoha on 2/9/23.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    let products: [Product] = [
        Product(id: 1, name: "Football", description: "Standard football mid range. The first was that your selector was missing the name of its parameter. ", inStock: true),
        Product(id: 1, name: "Cricket Bat", description: "Cricket bat high quality. Your code has two problems.", inStock: true),
        Product(id: 1, name: "Hockey stick", description: "Hockey stick mid range", inStock: false),
        Product(id: 1, name: "Rugby Ball", description: "Rugby ball description. One was identified and answered, but the other wasn't. The first was that your selector was missing the name of its parameter. ", inStock: true),
        Product(id: 1, name: "Adidas Shoe", description: "Adidas shoe description", inStock: false),
        Product(id: 1, name: "Puma Jersey", description: "Puma Jersey description", inStock: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Search Products"
        
        self.mTableView.dataSource = self
        self.mTableView.delegate = self
        
        self.mTableView.register(UINib(nibName: CellIdentifier.searchCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.searchCell)
        
        self.mTableView.estimatedRowHeight = 85.0
        self.mTableView.rowHeight = UITableView.automaticDimension
    }
    
    
}

extension SearchController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0,y: 0, width: self.view.frame.width, height: 40.0))
        view.backgroundColor = UIColor.systemCyan
        let label = UILabel(frame: CGRect(x: 20,y: 0, width: self.view.frame.width, height: 40.0))
        label.text = "Section Header"
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: SearchCell!
        if let mcell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchCell) as? SearchCell {
            cell = mcell
        }
        
       // cell.accessoryType = .disclosureIndicator
        let product = self.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.description
        if product.inStock {
            cell.stockLabel.text = "In Stock"
            cell.stockLabel.textColor = UIColor.green
        } else {
            cell.stockLabel.text = "Out Of Stock"
            cell.stockLabel.textColor = UIColor.lightGray
        }
        
        let image = UIImage(systemName: "soccerball")?.withRenderingMode(.alwaysTemplate)
        //image?.withTintColor(.brown)
        cell.productImage.image = image
        cell.productImage.tintColor = .brown
        
        return cell
        
    }
}


