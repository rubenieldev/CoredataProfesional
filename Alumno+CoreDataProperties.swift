//
//  Alumno+CoreDataProperties.swift
//  CoredataProfesional
//
//  Created by Ruben Ramirez on 1/8/20.
//  Copyright © 2020 Ruben Ramirez. All rights reserved.
//
//

import Foundation
import CoreData


extension Alumno {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alumno> {
        return NSFetchRequest<Alumno>(entityName: "Alumno")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var calificacion: Double
    @NSManaged public var foto: Data?
    @NSManaged public var numerocalificaciones: Int16
    @NSManaged public var ultimavez: Date?

}
