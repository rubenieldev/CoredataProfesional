//
//  ViewController.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/8/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    //Siempre que usemos CoreData necesitamos de un managedContext
    var managedContext:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guardarValores()
        // Do any additional setup after loading the view.
        /*var variable:String?
        variable = "hola mundo"
        
        //Forma 3 guard
        
        guard let variableAux = variable else{
            print("al abrir la caja no tenia contenido")
            return
        }
        
        print(variableAux)*/
        
        //Forma numero 2, if let
        /*if let variable_aux = variable {
            print(variable_aux)
        }*/
        
        //Forma numero 1, por fuerza bruta (variable!)
        //print(variable!)
        
        
        /*var hola = Bundle.main.object(forInfoDictionaryKey: "hola")
        guard let holaDos = hola else{
            return
        }
        
        print(holaDos)*/
        
        //Guardar un alumno por defecto
        /*
        let Alumno = NSEntityDescription.insertNewObject(forEntityName: "Alumno", into: managedContext) as? Alumno
        
        Alumno?.nombre = "Victor"
        
        do{
            
            try managedContext.save()
            
        }catch let error as NSError{
            
            print("\(error.userInfo)")
            
        }*/
        
        let peticion = NSFetchRequest<Alumno>(entityName: "Alumno")
        do{
            let resultado = try managedContext.fetch(peticion)
            let resultadoFinal = resultado.first
            print(resultadoFinal?.nombre)
        }catch let error as NSError{
            print("\(error.userInfo)")
        }
        
        
    }

    func guardarValores(){
        var alumnosPlist = Bundle.main.path(forResource: "DatosAlumno", ofType: "plist")
        var arrayAlumnos = NSArray(contentsOfFile: alumnosPlist!)!
        
        for alumno in arrayAlumnos {
            //Se hace la conexion a la base de datos
            let entity = NSEntityDescription.entity(forEntityName: "Alumno", in: managedContext)!
            let alumnoEntity = Alumno(entity: entity, insertInto: managedContext)
            
            //Se hace cast del alumno como diccionario
            let dicAlumno = alumno as! [String: AnyObject]
            
            //Asignar la Foto
            let nombreFoto = dicAlumno["foto"] as? String
            let imagen = UIImage(named: nombreFoto!)
            let dataImagen = imagen!.jpegData(compressionQuality: 0.5)
            alumnoEntity.foto = NSData(data: dataImagen!) as Data
            
            //Asignar los otros valores
            alumnoEntity.nombre = dicAlumno["nombre"] as? String
            alumnoEntity.ultimavez = dicAlumno["ultimavez"] as? Date
            alumnoEntity.calificacion = (dicAlumno["calificacion"] as? Double)!
            alumnoEntity.numerocalificaciones = (dicAlumno["numerocalificaciones"] as? Int16)!
            
        }
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("\(error.userInfo)")
        }
    }
}

