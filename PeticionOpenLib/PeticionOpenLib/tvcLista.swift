//
//  tvcLista.swift
//  PeticionOpenLib
//
//  Created by Fernando Rojas Hidalgo on 6/8/18.
//  Copyright © 2018 Rohisa. All rights reserved.
//

import UIKit

class tvcLista: UITableViewController {
    
    var datos = Datos()
    var libroSel:String="NA"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let rightBarButton = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(irBuscarLibro))


        self.navigationItem.rightBarButtonItem = rightBarButton
        
        datos.array = []

    }

    @objc func irBuscarLibro(){
        libroSel = "NA"
        self.performSegue(withIdentifier: "idBuscarLibro", sender: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datos.array.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = datos.array[indexPath.row]
        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        libroSel = datos.array[indexPath.row]
        performSegue(withIdentifier: "idBuscarLibro", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idBuscarLibro" {
            let destination = segue.destination as! buscarLibro
            destination.datos = datos
            destination.libroElejido = libroSel
            print(libroSel)
        }
    }

}
