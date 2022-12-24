//
//  CoreDataViewModel.swift
//  CoreDataCRUD
//
//  Created by Macbook on 24/12/22.
//

import CoreData

final class CoreDataViewModel: ObservableObject {
    var container: NSPersistentContainer
    @Published var savedFruits: [FruitsEntity] = []
    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        self.container.loadPersistentStores {
            description, error in
            if let error = error {
                print("Error while loading container \(error)")
            } else {
                print("SUCCESSFULLY loaded!")
            }
        }
        self.fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitsEntity>(entityName: "FruitsEntity")
        
        do {
            savedFruits = try self.container.viewContext.fetch(request)
        } catch let error {
            print("Error while fetch entities \(error)")
        }
    }
    
    func addFruits(name: String) {
        let newFruit = FruitsEntity(context: self.container.viewContext)
        newFruit.name = name
        saveData()
    }
    
    func saveData() {
        do {
            try self.container.viewContext.save()
            self.fetchFruits()
        } catch let error {
            print("Error while save data \(error)")
        }
    }
    
    func deleteFruit(indexSet: IndexSet) {
        
        guard let index = indexSet.first else { return }
        
        let entity = self.savedFruits[index]
        self.container.viewContext.delete(entity)
        self.saveData()
    }
    
    func update(_ entity: FruitsEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        
        self.saveData()
    }
}
