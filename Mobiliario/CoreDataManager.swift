//
//  CoreDataManager.swift
//  
//
//  Created by Berenice Olivas 
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer : NSPersistentContainer

    init(){
        persistentContainer = NSPersistentContainer(name: "Mobiliario")
        persistentContainer.loadPersistentStores(completionHandler:{
            (description, error) in
            if let error = error{
                fatalError("Core data failed\(error.localizedDescription)")
            }
            
        })
    }

    func guardarMobiliario(id:String, nombre:String, precioUnitario:String, existencia:String, categoria:String ){
        let viga = Viga(context: persistentContainer.viewContext)
        viga.id = id
        viga.nombre = nombre
        viga.precioUnitario = precioUnitario
        viga.existencia = existencia
        viga.categoria = categoria
        
        do{
            try persistentContainer.viewContext.save()
            print("Mobiliario guardado correctamente")
        }
        catch{
            print ("Error al guardar, \(error)")
        }
    }

    func leerTodosMobiliarios() -> [Mobiliario] {
        let fetchRequest : NSFetchRequest<Mobiliario> = Mobiliario.fetchRequest()
        do{
            return try persistentContainer.viewContext.fetch(fetchRequest)
        }
        catch{
            return[]
        }
    }
    
    func borrarMobiliario(Mobiliario:Mobiliario){
        persistentContainer.viewContext.delete(Mobiliario)

        do{
            try persistentContainer.viewContext.save()
        }
        catch{
            persistentContainer.viewContext.rollback()
            print("Error al guardar contexto, \(error.localizedDescription)")
        }
        return nil
    }
}