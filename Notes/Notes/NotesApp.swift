//
//  NotesApp.swift
//  Notes
//
//  Created by Vyacheslav on 05.03.2023.
//

import SwiftUI

/*
 
 Обязательные требования:
     • Создание одной простейшей заметки только с текстом;
     • Редактирование заметки в окне собственного приложения;
     • Сохранение заметки между сеансами приложения, в любом формате;
     • При первом запуске приложение должно иметь одну заметку с текстом.

 Желательно:
     • Создание нескольких заметок в приложении;
     • Выводить список существующих заметок;
     • Возможность редактирования любой заметки из списка;
     • Удаление заметок;
     • Также сохранять все заметки между сеансами.
 
 Идеи для улучшения:
     • Возможность выделять текст курсивом, жирным и т. п.;
     • Менять шрифт и размер текста;
     • Вставка картинок.
 
 */

@main
struct NotesApp: App {
    @StateObject private var store = NotesStory()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NotesView(notes: $store.notes) {
                    NotesStory.save(notes: store.notes) { result in
                        if case .failure(let failure) = result {
                            fatalError(failure.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                NotesStory.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let notes):
                        store.notes = notes
                    }
                }
            }
        }
    }
}
