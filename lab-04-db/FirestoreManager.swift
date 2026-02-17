import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseFirestoreSwift

class FirestoreManager: ObservableObject {
    private var db = Firestore.firestore()
    @Published var notes = [Note]()

    private func notesCollection() -> CollectionReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(uid).collection("notes")
    }

    // Create Note
    func addNote(title: String, content: String) {
        guard let ref = notesCollection() else {
            print("No user logged in")
            return
        }
        let newNote = Note(title: title, content: content)
        do {
            _ = try ref.addDocument(from: newNote)
        } catch {
            print("Error adding document: \(error)")
        }
    }

    // Read Notes (real-time)
    func getNotes() {
        guard let ref = notesCollection() else {
            self.notes = []
            print("No user logged in")
            return
        }

        ref.order(by: "title").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error getting notes: \(error)")
                return
            }

            self.notes = snapshot?.documents.compactMap { document in
                try? document.data(as: Note.self)
            } ?? []
        }
    }

    // Update Note
    func updateNote(note: Note) {
        guard let ref = notesCollection(), let noteID = note.id else { return }
        do {
            try ref.document(noteID).setData(from: note)
        } catch {
            print("Error updating note: \(error)")
        }
    }

    // Delete Note
    func deleteNote(note: Note) {
        guard let ref = notesCollection(), let noteID = note.id else { return }
        ref.document(noteID).delete { error in
            if let error = error {
                print("Error deleting note: \(error)")
            }
        }
    }
}
