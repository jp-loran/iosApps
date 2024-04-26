//
//  EditNoteViewController.swift
//  Notas
//
//  Created by Juan Pablo Alvarez Loran on 25/04/24.
//

import UIKit

protocol EditNoteViewControllerDelegate: AnyObject {
    func didUpdateNote()
}

class EditNoteViewController: UIViewController {
    weak var delegate: EditNoteViewControllerDelegate?
    var receivedNote: Note?
    var noteIndex: Int?
    var notesManager = NotesManager()
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Información incompleta", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text=receivedNote?.title
        noteContent.text=receivedNote?.content
        
    }
    
    @IBAction func updateNote(_ sender: Any) {
        receivedNote?.title = noteTitle.text ?? ""
        receivedNote?.content = noteContent.text
        
        if receivedNote?.title.isEmpty ?? true || receivedNote?.content.isEmpty ?? true {
            showAlert(message: "Por favor completa todos los campos")
        }else{
            notesManager.updateNote(note: receivedNote!, at: noteIndex!)
            delegate?.didUpdateNote()
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func deleteNote(_ sender: Any) {
        notesManager.deleteNote(at: noteIndex!)
        delegate?.didUpdateNote()
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
