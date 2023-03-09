//
//  NotesStory.swift
//  Notes
//
//  Created by Vyacheslav on 08.03.2023.
//

import Foundation
import SwiftUI

class NotesStory: ObservableObject {
    @Published var notes: [Note] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("notes.data")
    }
    
    static func load(complection: @escaping (Result<[Note], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        complection(.success(Note.defaultNote))
                    }
                    return
                }
                
                let notes = try JSONDecoder().decode([Note].self, from: file.availableData)
                DispatchQueue.main.async {
                    complection(.success(notes))
                }
            }
            catch {
                DispatchQueue.main.async {
                    complection(.failure(error))
                }
            }
        }
    }
    
    static func save(notes: [Note], complection: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(notes)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    complection(.success(notes.count))
                }
            }
            catch {
                DispatchQueue.main.async {
                    complection(.failure(error))
                }
            }
        }
    }
    
}
