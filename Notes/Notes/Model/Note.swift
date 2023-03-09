//
//  Note.swift
//  Notes
//
//  Created by Vyacheslav on 05.03.2023.
//

import Foundation

struct Note: Identifiable, Codable {
    var id: UUID
    var noteText: String
    
    init(id: UUID = UUID(), noteText: String = "") {
        self.id = id
        self.noteText = noteText
    }
}

extension Note {
    static let defaultNote: [Note] = [
        Note(noteText: "Заметка по умолчанию, при первом запуске.")
    ]
}
