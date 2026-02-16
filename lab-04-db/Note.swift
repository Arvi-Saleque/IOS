import FirebaseFirestore
import FirebaseFirestoreSwift

struct Note: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var content: String
}
