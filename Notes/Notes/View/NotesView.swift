//
//  NotesView.swift
//  Notes
//
//  Created by Vyacheslav on 05.03.2023.
//

import SwiftUI

struct NotesView: View {
    @Binding var notes: [Note]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentedNewNote = false
    @State private var newNote = Note()
    let saveData: ()->Void
    
    var body: some View {
        List {
            ForEach($notes) { $note in
                NavigationLink(destination: NoteView(note: $note)) {
                    Text(note.noteText)
                        .lineLimit(1)
                }
            }
            .onDelete(perform: delete)
            .onMove(perform: move)
        }
        .navigationBarItems(leading: EditButton())
        .navigationTitle("Заметки")
        .toolbar {
            Button (action: {
                isPresentedNewNote = true
            }) {
                Image(systemName: "square.and.pencil")
            }
        }
        .sheet(isPresented: $isPresentedNewNote) {
            NavigationView {
                NoteView(note: $newNote)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Отменить") {
                                isPresentedNewNote = false
                                newNote = Note()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Сохранить") {
                                if !newNote.noteText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                    notes.append(newNote)
                                }
                                isPresentedNewNote = false
                                newNote = Note()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveData() }
        }
    }
    
    func delete(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        notes.move(fromOffsets: source, toOffset: destination)
    }
    
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotesView(notes: .constant(Note.defaultNote), saveData: {})
        }
    }
}

