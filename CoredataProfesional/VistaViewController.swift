//
//  VistaViewController.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/9/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//

import UIKit

class VistaViewController: UIViewController {

    @IBOutlet weak var imgFoto: UIImageView!
    var alumno:Alumno?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let datosImg = alumno?.foto
        imgFoto.image = UIImage(data: datosImg!)*/
        
        guard  let dataImg = alumno?.foto else {
            return
        }
        
        imgFoto.image = UIImage(data: dataImg)
        
    }
    

   
}
