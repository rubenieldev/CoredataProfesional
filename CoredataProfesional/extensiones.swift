//
//  extensiones.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/10/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    func decorar(radio:CGFloat, bkgColor:UIColor, tntCol:UIColor){
        self.layer.cornerRadius = radio
        self.backgroundColor = bkgColor
        self.tintColor = tntCol
        
    }
}

extension UIImageView{
    func redondearImg(radio:CGFloat){
        self.layer.cornerRadius = radio
    }
}
