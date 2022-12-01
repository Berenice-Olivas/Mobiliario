//
//  ContentView.swift
//  
//
//  reated by Berenice Olivas 
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    @State var id = ""
    @State var nombre = ""
    @State var precioUnitario = ""
    @State var existencia = ""
    @State var categoria = ""
    @State var seleccionado:Mobiliario?
    @State var mobiliarioArray = [Mobiliario]()
    
    var body: some View{
        VStack{
            TextField("ID Mobiliario", text: $id)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Nombre Mobiliario", text: $nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Precio Unitario", text: $precioUnitario)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Existencia", text: $existencia)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Categoria", text: $categoria)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("SAVE"){
                
                if (seleccionado != nil){
                    seleccionado?.id = id
                    seleccionado?.nombre = nombre
                    seleccionado?.precioUnitario = precioUnitario
                    seleccionado?.existencia = existencia
                    seleccionado?.categoria = categoria
                    coreDM.actualizarMobiliario(Mobiliario: seleccionado!)
                }else{
                    coreDM.guardarMobiliario(id: id, nombre: nombre, precioUnitario: precioUnitario, existencia: existencia, categoria: categoria)
                }
                mostrarMobiliarios()
                id = ""
                nombre = ""
                precioUnitario = ""
                existencia = ""
                categoria = ""
                seleccionado = nil
            }
            List{
                ForEach(mobiliarioArray, id: \.self){
                mob in
                VStack{
                    Text(mob.nombre ?? "")
                    Text(mob.id ?? "")
                    Text(mob.precioUnitario ?? "")
                    Text(mob.existencia ?? "")
                    Text(mob.categoria ?? "")
                }
                .onTapGesture {
                    seleccionado = mob
                    id = mob.id ?? ""
                    nombre = mob.nombre ?? ""
                    precioUnitario = mob.precioUnitario ?? ""
                    existencia = mob.existencia ?? ""
                    categoria = mob.categoria ?? ""
                }
            }
            .onDelete(perform: {
                indexSet in
                indexSet.forEach({index in
                    let mobiliario = mobiliarioArray[index]
                    coreDM.borrarMobiliario(Mobiliario: Mobiliario)
                    mostrarMobiliarios()
                })
            })
        }
        Spacer()
    }.padding()
        .onAppear(perform: {
            mostrarMobiliarios()
        })
        
    }

    func mostrarMobiliarios(){
        mobiliarioArray = coreDM.leerTodosMobiliarios()
    }
}


struct ContentView_preViews: PreviewProvider{
    static var previews: some View{
        ContentView(coreDM: CoreDataManager())
    }
}



    
