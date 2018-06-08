
//
//  ViewController.swift
//  PeticionOpenLib
//
//  Created by Fernando Rojas Hidalgo on 5/28/18.
//  Copyright © 2018 Rohisa. All rights reserved.
//

import UIKit

class buscarLibro: UIViewController, UINavigationControllerDelegate {
 
    var datos = Datos()
    var libroElejido:String?

    
    @IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var txtParametro: UITextField!
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var lblAutores: UILabel!
    @IBOutlet weak var lblPortada: UILabel!
    @IBOutlet weak var imgPortada: UIImageView!
    
    func sincrono(){
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + txtParametro.text!
        let url =  NSURL(string: urls)
        let datosNS = NSData(contentsOf: url! as URL)
        let texto = NSString(data:datosNS! as Data, encoding:String.Encoding.utf8.rawValue)
        print("Viene")
        print(texto)
      
        do{
            let json = try JSONSerialization.jsonObject(with: datosNS! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves)
            
            let libro = txtParametro.text

            var raiz = "ISBN:" + txtParametro.text!
            let dic1 = json as! NSDictionary
            
            if let dic2 = dic1[raiz] as? NSDictionary {
                
                if let index = datos.array.index(of: libro!) {
                }else{
                    datos.array.append(libro!)
                    
                }
                                
                var titulo = dic2["title"]! as! NSString as String
                lblTitulo.text = "Titulo: \(titulo)"
                
                txtParametro.isEnabled = false
                
                if (dic2["cover"] != nil){
                    let dicCover = try dic2["cover"] as! NSDictionary
                    if (dicCover.count > 0){
                        let cover = dicCover["medium"]! as! NSString as String
                        print(cover)
                        let url = URL(string: cover)
                        print(url)
                        
                        let dataImg = try? Data(contentsOf: url!)
                        
                        if (dataImg != nil){
                            print(dataImg)
                            imgPortada.image = UIImage(data: dataImg!)
                            lblPortada.isHidden = false;
                        }
                        
                    }else{
                        lblPortada.isHidden = true;
                    }
                }
                
                let dicAutores = dic2["authors"] as? NSArray
                
                for item in dicAutores! { // loop through data items
                    let obj = item as! NSDictionary
                    var autores :String = "Autores: \n"
                    var cont : Int = 1
                    
                    for (key, value) in obj {
                        if (key as! String == "name"){
                            autores += "\(cont) - \(value) \n"
                            cont = cont + 1
                        }
                        
                        lblAutores.text = autores
                        
                    }
                }
            }
            
        }catch{
            
        }
        
    
        lblMensaje.text = texto! as String
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if (libroElejido != "NA" && libroElejido != ""){
            txtParametro.text = libroElejido
        }else{
            txtParametro.text = ""
        }
        
        libroElejido = nil

        
        do {
            Network.reachability = try Reachability(hostname: "www.google.com")
            do {
                try Network.reachability?.start()
            } catch let error as Network.Error {
                print(error)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Invocar(_ sender: UIButton) {
        if (txtParametro.text != ""){
            if (Network.reachability?.isReachable)!{
                sincrono()
            }else{
                lblMensaje.text = "No hay internet"
                print("Error: No hay conexión a Internet")
            }
        }
    }
    
    
}



//    func sincrono(){
//        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + txtParametro.text!
//        let url =  NSURL(string: urls)
//        let datos:NSData? =  NSData(contentsOf: url! as URL)
//        let texto = NSString(data:datos! as Data, encoding:String.Encoding.utf8.rawValue)
//        lblMensaje.text = texto! as String
//    }
//
//
//    func asincrono(){
//
//        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + self.txtParametro.text!
//        let url = NSURL(string: urls)
//        let sesion = URLSession.shared
//
//        let bloque = {(datos: Data?, resp : URLResponse?, error : Error?) -> Void in let texto = NSString(data: datos! as Data, encoding:String.Encoding.utf8.rawValue)
//             DispatchQueue.main.async {
//                self.lblMensaje.text = texto! as String}}
//        let dt = sesion.dataTask(with: url! as URL,completionHandler: bloque)
//        dt.resume()
//
//    }




