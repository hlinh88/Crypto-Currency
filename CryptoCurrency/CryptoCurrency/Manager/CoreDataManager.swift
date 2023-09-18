//
//  CoreDataManager.swift
//  CryptoCurrency
//
//  Created by Hoang Linh Nguyen on 18/9/2023.
//

import CoreData

class CoreDataManager {
    let request = Favourite.fetchRequest()

    static let shared = CoreDataManager()

    private init() {}

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CryptoCurrency")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func getAllItems() {
        let context = persistentContainer.viewContext
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                if let fav = result as? Favourite {
                    FavouriteManager.favourites.append(fav)
                }
            }
        } catch {
            print("Fetch failed")
        }
    }

    func saveItem(favouriteCoinInfo: [String: String]) {
        let context = persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: context) {
            let newFavourite = Favourite(entity: entity, insertInto: context)
            newFavourite.uuid = favouriteCoinInfo["uuid"]
            newFavourite.name = favouriteCoinInfo["name"]
            newFavourite.symbol = favouriteCoinInfo["symbol"]
            newFavourite.iconUrl = favouriteCoinInfo["iconUrl"]
            newFavourite.color = favouriteCoinInfo["color"]
            newFavourite.price = favouriteCoinInfo["price"]
            do {
                try context.save()
                FavouriteManager.favourites.append(newFavourite)
            } catch {
                print("Context save error")
            }
        }
    }

    func deleteItem(uuid: String) {
        let context = persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "uuid == %@", uuid)
        do {
            deleteItemFromList(uuid: uuid)
            let results: NSArray = try context.fetch(request) as NSArray
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                    try context.save()
                }
            }
        } catch let error as NSError {
            print("Detele data in Favourite error : \(error) \(error.userInfo)")
        }
    }

    private func deleteItemFromList(uuid: String) {
        FavouriteManager.favourites = FavouriteManager.favourites.filter { $0.uuid != uuid }
    }
}
