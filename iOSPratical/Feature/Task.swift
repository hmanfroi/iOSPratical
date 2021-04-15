//
//  Task.swift
//  iOSPratical
//
//  Created by Alexandre Bing on 08/04/21.
//

import Foundation

struct Task {
    var taskText: String
    var taskDone: Bool
}

extension Task {
    init(_ text: String, _ done: Bool){
        taskText = text
        taskDone = done
    }
}

struct MockTests {
    var tasks: [Task] = [Task("Lavar louça", true), Task("Levar carro no mecânico", false), Task("Comprar café", false), Task("Lavar louça", true), Task("Levar carro no mecânico", false), Task("Comprar café", false), Task("Lavar louça", true), Task("Levar carro no mecânico", false), Task("Comprar café", false), Task("Lavar louça", true), Task("Levar carro no mecânico 7", false), Task("Comprar café 7", false), Task("Lavar louça 7", true), Task("Levar carro no mecânico 7", false), Task("Comprar café 8", false), Task("Lavar louça 8", true), Task("Levar carro no mecânico 8", false), Task("Comprar café 8", false), Task("Lavar louça 8", true), Task("Levar carro no mecânico 8", false), Task("Comprar café 8", true)]
}
