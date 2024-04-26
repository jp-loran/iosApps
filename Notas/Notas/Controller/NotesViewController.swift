//
//  NotesViewController.swift
//  Notas
//
//  Created by Rafael González on 19/04/24.
//

import UIKit

class NotesViewController: UITableViewController, EditNoteViewControllerDelegate {
    
    @IBOutlet var emptyNotesView: UIView!
    @IBOutlet var noteList: UITableView!
    var notesManager = NotesManager()
    var note : Note?
    
    func updateEmptyNotesViewVisibility() {
        if notesManager.countNotes() == 0 {
            emptyNotesView.isHidden = false
            noteList.backgroundView = emptyNotesView
        } else {
            emptyNotesView.isHidden = true
            noteList.backgroundView = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteList.reloadData()
        notesManager.loadNotes()
        updateEmptyNotesViewVisibility()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesManager.countNotes()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NoteCell
        
        cell?.noteTitle.text = notesManager.getNote(at: indexPath.row).title
        cell?.noteDate.text = notesManager.getNote(at: indexPath.row).date.description
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           // Perform the segue with the "editNote" identifier
           performSegue(withIdentifier: "editNote", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "editNote" {
                if let indexPath = sender as? IndexPath {
                    let editNoteVC = segue.destination as! EditNoteViewController
                    // Pass the selected note to the AddNoteViewController
                    editNoteVC.receivedNote = notesManager.getNote(at: indexPath.row)
                    editNoteVC.noteIndex = indexPath.row
                }
            }
        
            if let editorVC = segue.destination as? EditNoteViewController {
                  editorVC.delegate = self
            }
        }
    
    func didUpdateNote() {
        notesManager.loadNotes()
        updateEmptyNotesViewVisibility()
        noteList.reloadData()
    }
    
    //Unwind segue
    @IBAction func unwindToNotesViewController(_ segue: UIStoryboardSegue) {
        if let source = segue.source as? AddNoteViewController {
            let newNote = source.newNote
            notesManager.createNote(note: newNote!)
            notesManager.saveNotes()
        } 
        noteList.reloadData()
        updateEmptyNotesViewVisibility()
    }
    
}
