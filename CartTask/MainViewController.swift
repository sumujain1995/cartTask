//
//  MainViewController.swift
//  CartTask
//
//  Created by Sumeet  Jain on 30/10/19.
//  Copyright © 2019 Sumeet Jain. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ShowFullImageProtocol, UpDateCroppedImage, DragDropChageModel {
    
    var productTableView = UITableView()
    var productCollectionView: UICollectionView?
    var rightBarButtonItem:UIBarButtonItem?
    var isGrid = true
    var sectionToShow = -1
    var categoriesData: [CategoriesModel] = []
    var loaderActivityView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loaderActivityView.style = .gray
        loaderActivityView.center = view.center
        loaderActivityView.startAnimating()
        navigationItem.title = "PRODUCTS"
        setMainUI()
        view.addSubview(loaderActivityView)
        getCategories()
    }
    
    //SET UP MAIN UI
    func setMainUI(){
        
        productTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productTableView)
        productTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        productTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        productTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        productTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        productTableView.delegate = self
        productTableView.dataSource = self
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "simpleCell")
        productTableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "simpleGrid")
        //REMOVE EMPTY CELLS
        productTableView.tableFooterView = UIView()

    }
    
    @objc func changeViewStyle(){
        isGrid = !isGrid
        rightBarButtonItem?.title = isGrid ? "GRID" : "LIST"
        productTableView.reloadData()
    }
    
    //TABLEVIEW DATASOURCE METHODS
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoriesData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isGrid{
            if sectionToShow == section{
                return categoriesData[section].products.count
            }
            return 0
        }
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isGrid {
            let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell") as! ProductTableViewCell
            cell.textLabel?.text = categoriesData[indexPath.section].products[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleGrid") as! ProductTableViewCell
        cell.section = indexPath.section
        cell.showFullImageDelegate = self
        cell.products = categoriesData[indexPath.section].products
        cell.productCollectionView?.reloadData()
        return cell
    }
    
    //TABLEVIEW DELEGATE METHODS
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if isGrid{
            return setUpListHeaderView(section)
        }
        return setUpGridHeaderView(section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isGrid{
            return UITableView.automaticDimension
        }
        return 500
    }
    
    //LIST VIEW -> HEADER VIEW SETUP
    func setUpListHeaderView(_ section: Int)-> UIView{
        let tableHeaderView = UIView()
        let headerLabel = UILabel()
        headerLabel.font = .boldSystemFont(ofSize: 25)
        headerLabel.text = categoriesData[section].name
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 10).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 15).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -10).isActive = true
        
        let expandLabel = UILabel()
        expandLabel.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.addSubview(expandLabel)
        expandLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 10).isActive = true
        expandLabel.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 15).isActive = true
        expandLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -10).isActive = true
        expandLabel.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -15).isActive = true
        
        if section == sectionToShow{
            expandLabel.text = "▼"
        }else{
            expandLabel.text = "▶︎"
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expandSection(_:)))
        tableHeaderView.addGestureRecognizer(tapGesture)
        tableHeaderView.tag = section
        tableHeaderView.isUserInteractionEnabled = true
        tableHeaderView.backgroundColor = UIColor.white
        return tableHeaderView
    }
    
    //GRID VIEW -> HEADER VIEW SETUP
    func setUpGridHeaderView(_ section: Int)-> UIView{
        let tableHeaderView = UIView()
        let headerLabel = UILabel()
        headerLabel.font = .boldSystemFont(ofSize: 25)
        headerLabel.text = categoriesData[section].name
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: tableHeaderView.topAnchor, constant: 10).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: tableHeaderView.leadingAnchor, constant: 15).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: tableHeaderView.bottomAnchor, constant: -10).isActive = true
        
        let nameSortButton = UIButton()
        nameSortButton.setTitleColor(UIColor.white, for: .normal)
        nameSortButton.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.addSubview(nameSortButton)
        
        switch categoriesData[section].sortName {
        case -1:
            nameSortButton.setTitle("Name ", for: .normal)
        case 0:
            nameSortButton.setTitle("Name ⇣", for: .normal)
        case 1:
            nameSortButton.setTitle("Name ⇡", for: .normal)
        default:
            break
        }
        
        nameSortButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        nameSortButton.trailingAnchor.constraint(equalTo: tableHeaderView.trailingAnchor, constant: -15).isActive = true
        nameSortButton.centerYAnchor.constraint(equalTo: tableHeaderView.centerYAnchor).isActive = true
        nameSortButton.layer.cornerRadius = 3.0
        nameSortButton.backgroundColor = UIColor.lightGray
        nameSortButton.tag = section
        nameSortButton.addTarget(self, action: #selector(sortByName(_:)), for: .touchUpInside)
        
        let priceSortButton = UIButton()
        priceSortButton.setTitleColor(UIColor.white, for: .normal)
        
        switch categoriesData[section].sortPrice {
        case -1:
            priceSortButton.setTitle("Price ", for: .normal)
        case 0:
            priceSortButton.setTitle("Price ⇣", for: .normal)
        case 1:
            priceSortButton.setTitle("Price ⇡", for: .normal)
        default:
            break
        }

        priceSortButton.translatesAutoresizingMaskIntoConstraints = false
        tableHeaderView.addSubview(priceSortButton)
        priceSortButton.translatesAutoresizingMaskIntoConstraints = false
        priceSortButton.widthAnchor.constraint(equalToConstant: 90).isActive = true
        priceSortButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 15).isActive = true
        priceSortButton.trailingAnchor.constraint(equalTo: nameSortButton.leadingAnchor, constant: -5).isActive = true
        priceSortButton.centerYAnchor.constraint(equalTo: tableHeaderView.centerYAnchor).isActive = true
        priceSortButton.layer.cornerRadius = 3.0
        priceSortButton.backgroundColor = UIColor.lightGray
        priceSortButton.tag = section
        priceSortButton.addTarget(self, action: #selector(sortByPrice(_:)), for: .touchUpInside)
        tableHeaderView.backgroundColor = UIColor.white
        return tableHeaderView
    }
    //HEADER CLICK METHOD
    @objc func expandSection(_ sender: UITapGestureRecognizer){
        if let section = sender.view?.tag{
            if section == sectionToShow{
                
                //COLLAPSE THE SECTION
                let temp = sectionToShow
                sectionToShow = -1
                productTableView.reloadSections([temp], with: .automatic)
            }else{
                
                //EXPAND THE SECTION
                if sectionToShow != -1{
                    let temp = sectionToShow
                    sectionToShow = section
                    productTableView.reloadSections([temp,section], with: .automatic)
                }else{
                    sectionToShow = section
                    productTableView.reloadSections([section], with: .automatic)
                }
            }
        }
    }
    
    @objc func sortByName(_ sender: UIButton){
        let section = sender.tag
        if categoriesData[section].sortName == -1 || categoriesData[section].sortName == 0{
            let products = categoriesData[section].products.sorted(by: {$0.name > $1.name})
            categoriesData[section].products = products
            categoriesData[section].sortName = 1
            categoriesData[section].sortPrice = -1
            productTableView.reloadSections([section], with: .automatic)
        }else if categoriesData[section].sortName == 1{
            let products = categoriesData[section].products.sorted(by: {$0.name < $1.name})
            categoriesData[section].products = products
            categoriesData[section].sortName = 0
            categoriesData[section].sortPrice = -1
            productTableView.reloadSections([section], with: .automatic)
        }
    }
    
    @objc func sortByPrice(_ sender: UIButton){
        let section = sender.tag
        if categoriesData[section].sortPrice == -1 || categoriesData[section].sortPrice == 0{
            let products = categoriesData[section].products.sorted(by: {$0.cost > $1.cost})
            categoriesData[section].products = products
            categoriesData[section].sortPrice = 1
            categoriesData[section].sortName = -1
            productTableView.reloadSections([section], with: .automatic)
        }else if categoriesData[section].sortPrice == 1{
            let products = categoriesData[section].products.sorted(by: {$0.cost < $1.cost})
            categoriesData[section].products = products
            categoriesData[section].sortPrice = 0
            categoriesData[section].sortName = -1
            productTableView.reloadSections([section], with: .automatic)

        }
        
    }
    
    //GET CATEGORIES FROM API
    func getCategories(){
        
        Webservice.sharedInstance.requestCategories { [weak self] (data, error) in
            if let apiData = data{
                do{
                    let categories = try JSONDecoder().decode([CategoriesModel].self, from: apiData)

                    //Prepare Data
                    var categoriesArr: [String] = []
                    for index in 0 ..< categories.count{
                        if !categories[index].products.isEmpty{
                            if categoriesArr.contains(categories[index].name), let changeIndex = categoriesArr.firstIndex(of: categories[index].name){
                                self?.categoriesData[changeIndex] = categories[index]
                            }else{
                                self?.categoriesData.append(categories[index])
                                categoriesArr.append(categories[index].name)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self?.loaderActivityView.stopAnimating()
                        self?.loaderActivityView.removeFromSuperview()
                        self?.rightBarButtonItem = UIBarButtonItem(title: "GRID", style: .done, target: self, action: #selector(self?.changeViewStyle))
                        self?.navigationItem.rightBarButtonItem = self?.rightBarButtonItem
                        self?.productTableView.reloadData()
                    }
                }catch{
                    self?.showAlertView("Error", msg: "SOMETHING WENT WRONG")
                }
            }else{
                if let errMsg = error?.localizedDescription{
                    self?.showAlertView("Error", msg: errMsg)
                }else{
                    self?.showAlertView("Error", msg: "SOMETHING WENT WRONG")
                }
            }
        }
    }
    
    func fullImage(_ section: Int, row: Int, image: UIImage?) {
        let fullImageVC = FullImageViewController()
        fullImageVC.imageView.image = image
        fullImageVC.upDateCroppedImageDelegate = self
        fullImageVC.imageIndexPath = IndexPath(row: row, section: section)
        UIView.beginAnimations("animation", context: nil)
        UIView.setAnimationDuration(1.0)
        self.navigationController?.pushViewController(fullImageVC, animated: false)
        UIView.setAnimationTransition(UIView.AnimationTransition.flipFromRight, for: self.navigationController!.view, cache: false)
        UIView.commitAnimations()
    }
    
    func updateImage(indexPath: IndexPath, image: CGImage?) {
        categoriesData[indexPath.section].products[indexPath.row].image = image
        productTableView.reloadSections([indexPath.section], with: .automatic)
    }
    
    func changeProductPosition(_ source: Int, destination: Int, section: Int) {
        categoriesData[section].moveItem(at: source, to: destination)
    }
}
