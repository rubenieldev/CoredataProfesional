//
//  ViewController.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/8/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var table: UITableView!
    //Siempre que usemos CoreData necesitamos de un managedContext
    var managedContext:NSManagedObjectContext!
    
    var listaAlumnos:Array<Alumno> = []
    
    //para pruebas
    //var nombres:[String] = ["Ruben", "Marcos", "Jesus"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guardarValores()
        recuperarDatos()
        
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
        
       /* let peticion = NSFetchRequest<Alumno>(entityName: "Alumno")
        do{
            let resultado = try managedContext.fetch(peticion)
            let resultadoFinal = resultado.first
            print(resultadoFinal?.nombre)
        }catch let error as NSError{
            print("\(error.userInfo)")
        }*/
        
        
    }
    
    func recuperarDatos(){
        let peticion = NSFetchRequest<Alumno>(entityName: "Alumno")
        do{
            let alumnos = try managedContext.fetch(peticion)
            listaAlumnos = alumnos
            table.reloadData()
        }catch let error as NSError{
            print("\(error.userInfo)")
        }
    }

    func guardarValores(){
        
        let peticion = NSFetchRequest<Alumno>(entityName: "Alumno")
        peticion.predicate = NSPredicate(format: "nombre != nil")
        
        let cantidad = try! managedContext.count(for: peticion)
        
        if cantidad < 1 {
            
            print("Se insertaran valores por defecto")
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
            
        }else{
          print("Ya se han insertado valores por defecto")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return nombres.count
        return listaAlumnos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell
        let alumno = listaAlumnos[indexPath.row]
        
        cell?.dato = alumno.nombre
        cell?.delegate = self
        cell?.btbVer.decorar(radio: 10, bkgColor: .green, tntCol: .white)
        cell?.lblNombre.text = alumno.nombre
        cell?.alumno = alumno
        return cell!
    }
    
    //Funcion para ejecutarse cuando se le da click a la fila en la tabla
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(nombres[indexPath.row])
    }*/
    
    /*func seleccionado(dato: String) {
//        print(dato)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
    }*/
}

extension ViewController:Btnver{
    func seleccionado(dato: String, alumno:Alumno) {
//        print(dato)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controlador = storyBoard.instantiateViewController(identifier: "vista") as? VistaViewController
        controlador?.alumno = alumno
        controlador?.managedContext = self.managedContext
        present(controlador!, animated: true)
    }
    
    
}

