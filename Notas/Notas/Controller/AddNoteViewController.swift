//
//  AddNoteViewController.swift
//  Notas
//
//  Created by Juan Pablo Alvarez Loran on 20/04/24.
//

import UIKit

class AddNoteViewController: UIViewController, UITextViewDelegate {
    
    var newNote : Note?
    
    @IBOutlet weak var noteTitle: UITextField!
    
    @IBOutlet weak var noteContent: UITextView!
    
    let placeholderText = "Note content..."
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteContent.delegate = self
        noteContent.text = placeholderText
        noteContent.textColor = UIColor.lightGray
        print("Preparing to create a new note.")
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Información incompleta", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

       func textViewDidBeginEditing(_ textView: UITextView) {
           if textView.text == placeholderText {
               textView.text = ""
               textView.textColor = UIColor.black
           }
       }
       
       func textViewDidEndEditing(_ textView: UITextView) {
           if textView.text.isEmpty {
               textView.text = placeholderText
               textView.textColor = UIColor.lightGray
           }
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        newNote = Note(title: noteTitle.text ?? "", content: noteContent.text, date: Date())
        let destination = segue.destination as! NotesViewController
        destination.note = newNote
    }
    
    // MARK: - Navigation
        
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
           let titleText = noteTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if titleText?.isEmpty ?? true {
               showAlert(message: "Por favor ingresa el titlulo de la nota")
               return false
           } else if noteContent.text == placeholderText || noteContent.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
               showAlert(message: "Por favor ia el contenido de la nota")
               return false
           }
           return true
       }}
