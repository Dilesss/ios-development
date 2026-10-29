import Foundation

struct Track {
    let title: String
    let artist: String
    let fileName: String        // with extension, e.g. "track01.mp3"
    let coverImageName: String  // name in Assets.xcassets
}

enum TrackLibrary {
    // Replace titles and artists with the real ones from the site you downloaded from
    static let tracks: [Track] = [
        Track(title: "Title 1",  artist: "Artist 1",  fileName: "track01.mp3", coverImageName: "cover01"),
        Track(title: "Title 2",  artist: "Artist 2",  fileName: "track02.mp3", coverImageName: "cover02"),
        Track(title: "Title 3",  artist: "Artist 3",  fileName: "track03.mp3", coverImageName: "cover03"),
        Track(title: "Title 4",  artist: "Artist 4",  fileName: "track04.mp3", coverImageName: "cover04"),
        Track(title: "Title 5",  artist: "Artist 5",  fileName: "track05.mp3", coverImageName: "cover05"),
        Track(title: "Title 6",  artist: "Artist 6",  fileName: "track06.mp3", coverImageName: "cover06"),
        Track(title: "Title 7",  artist: "Artist 7",  fileName: "track07.mp3", coverImageName: "cover07"),
        Track(title: "Title 8",  artist: "Artist 8",  fileName: "track08.mp3", coverImageName: "cover08"),
        Track(title: "Title 9",  artist: "Artist 9",  fileName: "track09.mp3", coverImageName: "cover09"),
        Track(title: "Title 10", artist: "Artist 10", fileName: "track10.mp3", coverImageName: "cover10")
    ]
}
