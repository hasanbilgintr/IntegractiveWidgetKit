//
//  ToDo.swift
//  IntegractiveWidgetKit
//
//  Created by hasan bilgin on 28.11.2023.
//

import Foundation

struct ToDo : Identifiable {
    //    let id : UUID = UUID()  farketmez
    //  intent string ister olamdı orda dönüşüm sağlarız
    let id : String = UUID().uuidString
    var name : String
    var isDone : Bool = false

}

class SharedDates {
    //Singlton yapısı / heryerden ulaşmak için
    static let shared = SharedDates()
    
    //dizi oluşturup modelden türetttik diyebiliriz
    var toDos : [ToDo] = [.init(name: "To Do 1"),.init(name: "To Do 2"),.init(name: "To Do 3")]
}
