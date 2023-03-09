//
//  ContentView.swift
//  Notes
//
//  Created by Vyacheslav on 05.03.2023.
//

import SwiftUI

struct NoteView: View {
    @Binding var note: Note
    
    var body: some View {
        TextEditor(text: $note.noteText)
            .cornerRadius(15)
            .padding()
            .background(.ultraThinMaterial)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: .constant(Note.defaultNote[0]))
    }
}
