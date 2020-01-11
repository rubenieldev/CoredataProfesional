//
//  TableViewCell.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/9/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//

import UIKit

protocol Btnver {
    func seleccionado(dato:String, alumno:Alumno)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var btbVer: UIButton!
    @IBOutlet weak var lblNombre: UILabel!
    
    var delegate:Btnver?
    var dato:String?
    var alumno:Alumno?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func visualizar(_ sender: Any) {
        delegate?.seleccionado(dato: dato!, alumno: alumno!)
    }
    
}
