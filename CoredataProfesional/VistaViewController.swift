//
//  VistaViewController.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/9/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//

import UIKit
import CoreData

class VistaViewController: UIViewController {
    
    var managedContext:NSManagedObjectContext?

    @IBOutlet weak var imgFoto: UIImageView!
    var alumno:Alumno?
    @IBOutlet weak var btnCalificar: UIButton!
    
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lblCalificacion: UILabel!
    @IBOutlet weak var lblUltimaVez: UILabel!
    @IBOutlet weak var lblVecesCalificado: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCalificar.decorar(radio: 5, bkgColor: .blue, tntCol: .white)
        imgFoto.redondearImg(radio: 90)
        /*let datosImg = alumno?.foto
        imgFoto.image = UIImage(data: datosImg!)*/
        
        
        
       verDatos()
        
    }
    
    func verDatos(){
        guard  let auxAlumno = alumno else {
                   return
               }
               
               imgFoto.image = UIImage(data: auxAlumno.foto!)
               lblNombre.text = auxAlumno.nombre
               lblCalificacion.text = "\(Double(auxAlumno.calificacion))"
               let formato = DateFormatter()
               
               formato.dateStyle = .medium
               formato.timeStyle = .medium
               
               lblUltimaVez.text = formato.string(from: auxAlumno.ultimavez!)
               lblVecesCalificado.text = "\(auxAlumno.numerocalificaciones)"
    }
    
    @IBAction func calificar(_ sender: Any) {
        let alerta = UIAlertController(title: "Calificar", message: "Calificar del 1 al 10", preferredStyle: .alert)
        
        alerta.addTextField{(campoTexto) in
            campoTexto.keyboardType = .numberPad
        }
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let calificarBtn = UIAlertAction(title: "Calificar", style: .default){ [unowned self] action in
            
            let calificacion = alerta.textFields?.first?.text
            guard let  auxCalif = alerta.textFields?.first?.text else{
                return
            }
            
            let auxCalificacion:Double = Double(auxCalif)!
            
            if auxCalificacion > 0 && auxCalificacion < 11{
                self.alumno?.ultimavez = Date()
                let vecesCalificado = self.alumno!.numerocalificaciones
                self.alumno!.numerocalificaciones = vecesCalificado + 1
                
                let calificacionActual = self.alumno!.calificacion
                
                let nuevaCalificacion = (auxCalificacion + calificacionActual) / Double((vecesCalificado + 1))
                self.alumno!.calificacion = nuevaCalificacion
                
                do{
                    try self.managedContext?.save()
                    self.verDatos()
                }catch let error as NSError{
                    print("\(error.userInfo)")
                }
            }else{
                let alerta = UIAlertController(title: "Error", message: "Valores deben de ser Mayor a 0 y menor a 11", preferredStyle: .alert)
                let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)
                alerta.addAction(cancelar)
                self.present(alerta, animated: true)
            }
            
            
        }
        alerta.addAction(cancelar)
        alerta.addAction(calificarBtn)
       
        present(alerta, animated: true)
    }
    

   
}
