//
//  DataStore.swift
//  TimeAto
//
//  Created by Azizbek Asadov on 10.12.2025.
//

import Foundation

struct DataStore {
    func dataFileURL() -> URL? {
        do {
            let fileManager = FileManager.default
            
            let docsFolder = try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            
            let dataURL = docsFolder.appendingPathComponent("Timeato-Tasks.json")
            return dataURL
        } catch {
            print("URL error: \(error.localizedDescription)")
            return nil
        }
    }
    
    func readTasks() -> [TaskItem] {
        guard let url = dataFileURL() else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let tasks = try JSONDecoder().decode([TaskItem].self, from: data)
            
            return tasks
        } catch {
            print("Read error: \(error.localizedDescription)")
            
            return []
        }
    }
    
    func save(tasks: [TaskItem]) {
        guard
            let url = dataFileURL(),
            let data = try? JSONEncoder().encode(tasks)
        else {
            return
        }
        do {
            try data.write(to: url)
        } catch {
            print("Save error: \(error.localizedDescription)")
        }
    }
}
