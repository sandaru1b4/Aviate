import Foundation

struct Flight: Codable, Identifiable {

    var id = UUID()
    var number: String?
    var iata: String?
    var icao: String?
    var codeshared: Codeshared?

    private enum CodingKeys: String, CodingKey {
        case number = "number"
        case iata = "iata"
        case icao = "icao"
        case codeshared = "codeshared"
    }

}
