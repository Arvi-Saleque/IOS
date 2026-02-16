import SwiftUI

struct FContentView: View {
    @StateObject private var firestoreManager = FirestoreManager()
    @State private var showingAddNote = false
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack{
            NavigationView {
                List {
                    ForEach(firestoreManager.notes) { note in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(note.title).font(.headline)
                                Text(note.content).font(.subheadline)
                            }
                            Spacer()
                            Button("Delete") {
                                firestoreManager.deleteNote(note: note)
                            }
                        }
                        .swipeActions {
                            Button("Edit") {
                                // handle editing note here
                                showingAddNote = true
                            }
                            .tint(.blue)
                        }
                    }
                }
                .navigationTitle("Notes")
                .navigationBarItems(trailing: Button(action: {
                    showingAddNote = true
                }) {
                    Image(systemName: "plus")
                })
                .onAppear {
                    firestoreManager.getNotes()
                }
                .sheet(isPresented: $showingAddNote) {
                    AddNoteView(firestoreManager: firestoreManager)
                }
            }

            Button(action: {
                authViewModel.signOut()
            }) {
                Text("Sign Out")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
}

