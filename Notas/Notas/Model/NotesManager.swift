//
//  NotesManager.swift
//  Notas
//
//  Created by Rafael González on 19/04/24.
//

import Foundation

class NotesManager {
    
    private var notes : [Note] = []
    
    func createNote(note : Note) {
        notes.append(note)
    }
    
    func deleteNote(at index : Int) {
        loadNotes()
        notes.remove(at: index)
        saveNotes()
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func getNote(at index : Int) -> Note {
        return notes[index]
    }
    
    func countNotes() -> Int {
        return notes.count
    }
    
    func updateNote(note: Note, at index : Int) {
        loadNotes()
        notes[index] = note
        saveNotes()
    }
    
    func saveNotes()  {
        //save json file with created notes
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("document directory: ", documentsDirectory)
        
        let notesURL = documentsDirectory.appending(path: "notes.json")
        
        print("notesURL: ", notesURL)
        
        //save [Note] as json file
        
        do{
            let jsonData = try JSONEncoder().encode(notes)
            fileManager.createFile(atPath: notesURL.path, contents: jsonData)
        }
        catch let error{
            print(error)
        }
    }
    
    func loadNotes(){
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let notesUrl = documentsDirectory.appendingPathComponent("notes.json")
        
        if fileManager.fileExists(atPath: notesUrl.path){
            do{
                let jsonData = fileManager.contents(atPath: notesUrl.path)
                notes = try JSONDecoder().decode([Note].self, from: jsonData!)
            }catch let error{
                print("Error: ", error)
            }
        }else{
            print("No se localizo el archivo")
        }
        
    }
    
    
    
    
    
}
