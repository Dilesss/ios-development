// MARK: - =================== STARTER DATA ===================
// MARK: - Do not modify anything in this section

/// Splits a line into fields.
/// fields("crate:101:120")            -> ["crate", "101", "120"]
/// fields("livestock:lab mice:12:2")  -> ["livestock", "lab mice", "12", "2"]
/// fields("junk")                     -> ["junk"]
func fields(_ line: String, separatedBy separator: Character = ":") -> [String] {
    var result: [String] = []
    var current = ""
    for character in line {
        if character == separator {
            result.append(current)
            current = ""
        } else {
            current.append(character)
        }
    }
    result.append(current)
    return result
}

/// Cargo manifest as recovered from the damaged recorder.
let rawManifest = [
    "crate:101:120",
    "container:KZ-ALM-7:340",
    "livestock:lab mice:12:2",
    "???-corrupted-line",
    "crate:102:75",
    "container:KZ-ALM-9:410",
    "livestock:ficus:3:5",
    "crate:103:260",
    "crate:104:abc",
    ""
]

/// Oxygen readings. One of these deck names is not a real deck.
let deckReadings: [(deck: String, oxygen: Int)] = [
    (deck: "bridge",     oxygen: 78),
    (deck: "lab",        oxygen: 64),
    (deck: "greenhouse", oxygen: 55),
    (deck: "cargo",      oxygen: 12),
    (deck: "medbay",     oxygen: 90),
    (deck: "engine",     oxygen: 41)
]

/// Crew records, straight from the personnel file.
let crewData: [(name: String, deck: String, oxygen: Int)] = [
    (name: "Timur",   deck: "engine", oxygen: 62),
    (name: "Dana",    deck: "lab",    oxygen: 48),
    (name: "Aigerim", deck: "bridge", oxygen: 91),
    (name: "Nurlan",  deck: "cargo",  oxygen: 17)
]

print("ALMA-7 recorder online: \(rawManifest.count) manifest lines, \(deckReadings.count) readings, \(crewData.count) crew records.")

// MARK: - ================= END OF STARTER DATA =================


// MARK: - =================== YOUR SOLUTION ===================


// MARK: Level 1 · The Deck Register

// 1.1
enum Deck: String, CaseIterable {
    case bridge, lab, cargo, medbay, engine

    var evacuationPriority: Int {
        switch self {
        case .bridge: return 1
        case .medbay: return 2
        case .lab:    return 3
        case .engine: return 4
        case .cargo:  return 5
        }
    }
}

for deck in Deck.allCases {
    print("\(deck.rawValue): priority \(deck.evacuationPriority)")
}

// 1.2
enum AlarmLevel: Int {
    case green = 0, yellow, orange, red

    static func level(forTotalMass mass: Int) -> AlarmLevel {
        let step = min(max(mass / 500, 0), AlarmLevel.red.rawValue)
        return AlarmLevel(rawValue: step) ?? .red
    }
}

print(AlarmLevel.level(forTotalMass: 0))
print(AlarmLevel.level(forTotalMass: 940))
print(AlarmLevel.level(forTotalMass: 4000))
print(AlarmLevel.orange.rawValue)


// MARK: Level 2 · The Manifest

// 2.1
enum ManifestEntry {
    case crate(id: Int, massKg: Int)
    case container(code: String, massKg: Int)
    case livestock(species: String, count: Int, massPerUnitKg: Int)
    case unknown(raw: String)
}

// 2.2
func parseEntry(_ line: String) -> ManifestEntry {
    let parts = fields(line)
    let tag = parts.first ?? ""

    switch tag {
    case "crate":
        guard parts.count == 3,
              let id = Int(parts[1]),
              let massKg = Int(parts[2])
        else { return .unknown(raw: line) }
        return .crate(id: id, massKg: massKg)

    case "container":
        guard parts.count == 3,
              let massKg = Int(parts[2])
        else { return .unknown(raw: line) }
        return .container(code: parts[1], massKg: massKg)

    case "livestock":
        guard parts.count == 4,
              let count = Int(parts[2]),
              let massPerUnit = Int(parts[3])
        else { return .unknown(raw: line) }
        return .livestock(species: parts[1], count: count, massPerUnitKg: massPerUnit)

    default:
        return .unknown(raw: line)
    }
}

print(parseEntry("crate:101:120"))
print(parseEntry("livestock:lab mice:12:2"))
print(parseEntry("crate:104:abc"))

// 2.3
func mass(of entry: ManifestEntry) -> Int {
    switch entry {
    case .crate(_, let massKg):
        return massKg
    case .container(_, let massKg):
        return massKg
    case .livestock(_, let count, let massPerUnitKg):
        return count * massPerUnitKg
    case .unknown:
        return 0
    }
}

var totalMass = 0
var unknownCount = 0
for line in rawManifest {
    let entry = parseEntry(line)
    totalMass += mass(of: entry)
    if case .unknown = entry {
        unknownCount += 1
    }
}
print("Total manifest mass: \(totalMass) kg")
print("Unknown lines: \(unknownCount)")

let A = totalMass


// MARK: Level 3 · Crew Snapshots

// 3.1
struct CrewSnapshot {
    let name: String
    var deck: Deck
    var oxygen: Int

    mutating func breathe(_ amount: Int) {
        oxygen = max(0, oxygen - amount)
    }

    mutating func move(to deck: Deck) {
        self.deck = deck
    }

    mutating func reviveInMedbay() {
        self = CrewSnapshot(name: name, deck: .medbay, oxygen: 100)
    }

    static func rookie(named name: String) -> CrewSnapshot {
        CrewSnapshot(name: name, deck: .bridge, oxygen: 100)
    }
}

var testSnapshot = CrewSnapshot.rookie(named: "Rookie")
print(testSnapshot)
testSnapshot.breathe(120)
testSnapshot.move(to: .engine)
print(testSnapshot)
testSnapshot.reviveInMedbay()
print(testSnapshot)

// 3.2
func buildRoster(_ records: [(name: String, deck: String, oxygen: Int)]) -> [CrewSnapshot] {
    var result: [CrewSnapshot] = []
    for record in records {
        guard let deck = Deck(rawValue: record.deck) else {
            print("Warning: \(record.name) is on unknown deck '\(record.deck)', skipped")
            continue
        }
        result.append(CrewSnapshot(name: record.name, deck: deck, oxygen: record.oxygen))
    }
    return result
}

let crewRoster: [CrewSnapshot] = buildRoster(crewData)
print("Roster: \(crewRoster.count) crew members")
print(buildRoster([(name: "Ghost", deck: "greenhouse", oxygen: 50)]).count)

// 3.3 · Value-semantics demonstration

// 1. copy
var original = CrewSnapshot.rookie(named: "Aigerim")
var copy = original
print("1. before: original = \(original.oxygen), copy = \(copy.oxygen)")
copy.breathe(30)
print("1. after:  original = \(original.oxygen), copy = \(copy.oxygen)")

// 2. plain parameter
func drain(_ snapshot: CrewSnapshot) {
    var local = snapshot
    local.breathe(50)
    print("2. inside function: \(local.oxygen)")
}
print("2. before: original = \(original.oxygen)")
drain(original)
print("2. after:  original = \(original.oxygen)")

// 3. inout
func drainInPlace(_ snapshot: inout CrewSnapshot) {
    snapshot.breathe(50)
}
print("3. before: original = \(original.oxygen)")
drainInPlace(&original)
print("3. after:  original = \(original.oxygen)")


// MARK: Level 4 · The Teleport Pod

// 4.1
// CrewSnapshot is a struct, so Swift generates a memberwise init for it.
// Classes never get a memberwise init (only a default init() if every stored
// property has a default value). id and chargeLevel have no defaults here,
// so TeleportPod needs its own init.
final class TeleportPod {
    let id: String
    var chargeLevel: Int
    var occupant: CrewSnapshot?

    init(id: String, chargeLevel: Int) {
        self.id = id
        self.chargeLevel = chargeLevel
        self.occupant = nil
    }

    deinit {
        print("deinit: pod \(id) destroyed")
    }

    func load(_ crew: CrewSnapshot) -> Bool {
        guard occupant == nil, chargeLevel >= 20 else { return false }
        occupant = crew
        return true
    }

    func fire() -> CrewSnapshot? {
        guard let passenger = occupant else { return nil }
        chargeLevel -= 20
        occupant = nil
        return passenger
    }
}

// 4.2 · Charge ledger
func findCrew(_ name: String, in roster: [CrewSnapshot]) -> CrewSnapshot? {
    for member in roster where member.name == name {
        return member
    }
    return nil
}

let pod = TeleportPod(id: "P-1", chargeLevel: 100)
print("Start: charge \(pod.chargeLevel)")

for name in ["Timur", "Dana", "Nurlan"] {
    guard let member = findCrew(name, in: crewRoster) else {
        print("\(name) not found")
        continue
    }
    let loaded = pod.load(member)
    let arrived = pod.fire()
    print("\(name): loaded \(loaded), arrived \(arrived?.name ?? "nobody"), charge \(pod.chargeLevel)")
}

let emptyFire = pod.fire()
print("Empty fire: arrived \(emptyFire?.name ?? "nobody"), charge \(pod.chargeLevel)")

let C = pod.chargeLevel

// 4.3 · Reference-semantics demonstration
let podX = TeleportPod(id: "X", chargeLevel: 70)
let podY = podX
print("before: podX = \(podX.chargeLevel), podY = \(podY.chargeLevel)")
podY.chargeLevel = 10
print("after:  podX = \(podX.chargeLevel), podY = \(podY.chargeLevel)")

let snapX = CrewSnapshot.rookie(named: "Dana")
var snapY = snapX
print("before: snapX = \(snapX.oxygen), snapY = \(snapY.oxygen)")
snapY.oxygen = 10
print("after:  snapX = \(snapX.oxygen), snapY = \(snapY.oxygen)")

// Rule: assigning a class copies the reference (both names point to one object),
// assigning a struct copies the whole value (two independent values).


// MARK: Level 5 · Station Systems

// 5.1
// class: there is one station, and every part of the program must see the same live state
final class Station {
    let callSign: String
    var oxygenByDeck: [Deck: Int]

    var hullIntegrity: Int {
        willSet {
            print("Hull: \(hullIntegrity) -> \(newValue)")
        }
        didSet {
            if hullIntegrity > 100 {
                hullIntegrity = 100
            } else if hullIntegrity < 0 {
                hullIntegrity = 0
            }
        }
    }

    lazy var fullDiagnostics: String = {
        print("Running full scan...")
        var report = "\(self.callSign): hull \(self.hullIntegrity)%"
        for deck in Deck.allCases {
            report += ", \(deck.rawValue) \(self.oxygenByDeck[deck] ?? 0)"
        }
        return report
    }()

    var totalOxygen: Int {
        var sum = 0
        for (_, value) in oxygenByDeck {
            sum += value
        }
        return sum
    }

    var averageOxygen: Int {
        get {
            guard oxygenByDeck.count > 0 else { return 0 }
            return totalOxygen / oxygenByDeck.count
        }
        set {
            for deck in oxygenByDeck.keys {
                oxygenByDeck[deck] = newValue
            }
        }
    }

    init(callSign: String, readings: [(deck: String, oxygen: Int)], hullIntegrity: Int = 100) {
        self.callSign = callSign
        self.hullIntegrity = hullIntegrity
        var byDeck: [Deck: Int] = [:]
        for reading in readings {
            guard let deck = Deck(rawValue: reading.deck) else {
                print("Skipping unknown deck: \(reading.deck)")
                continue
            }
            byDeck[deck] = reading.oxygen
        }
        self.oxygenByDeck = byDeck
    }
}

let station = Station(callSign: "ALMA-7", readings: deckReadings)
print("Total oxygen: \(station.totalOxygen)")
print("Average oxygen: \(station.averageOxygen)")

let B = station.averageOxygen

print("Station created, diagnostics not touched yet")
print(station.fullDiagnostics)
print(station.fullDiagnostics)

let backupStation = Station(callSign: "ALMA-7B", readings: [(deck: "lab", oxygen: 30)])
print("Backup average: \(backupStation.averageOxygen)")

station.averageOxygen = 70
print("After setting average to 70: total \(station.totalOxygen), average \(station.averageOxygen)")

// 5.2 · The clamp trap
station.hullIntegrity = 130
print("hull = \(station.hullIntegrity)")
station.hullIntegrity = -40
print("hull = \(station.hullIntegrity)")
station.hullIntegrity = 55
print("hull = \(station.hullIntegrity)")

// Why no infinite loop: when a property is assigned inside its own didSet,
// Swift writes the value directly and does not call willSet/didSet again.
// So the clamp runs only once per outside assignment.


// MARK: Level 6 · Incident Reports
/*
// Report 1
var roster = crewRoster
for var member in roster {
    member.oxygen -= 10
}
print(roster[0].oxygen)   // author expected the crew to have lost oxygen

// Report 2
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = podA
podB.chargeLevel = 0
print(podA.chargeLevel)   // author expected 100

// Report 3
struct Logbook {
    var entries: [String] = []
    func add(_ entry: String) {
        entries.append(entry)
    }
}

// Report 4
let snapshot = CrewSnapshot.rookie(named: "Dana")
snapshot.oxygen = 40

let pod = TeleportPod(id: "B", chargeLevel: 50)
pod.chargeLevel = 10
*/

// Report 1
// Expected: every crew member loses 10 oxygen.
// Actual: prints 62, nothing changed. `member` is a copy of each element,
// the copy is changed and thrown away.
// Rule: structs are value types, the loop variable is a copy.
// Fix: change the elements in the array through their index.
var fixedRoster = crewRoster
for index in fixedRoster.indices {
    fixedRoster[index].breathe(10)
}
print("Report 1 fixed: \(fixedRoster[0].oxygen)")

// Report 2
// Expected: podA stays at 100.
// Actual: prints 0. podB is not a new pod, it is the same object.
// Rule: classes are reference types, assignment copies the reference.
// Fix: create a separate pod if you need an independent one.
let podA = TeleportPod(id: "A", chargeLevel: 100)
let podB = TeleportPod(id: "B", chargeLevel: podA.chargeLevel)
podB.chargeLevel = 0
print("Report 2 fixed: podA = \(podA.chargeLevel), podB = \(podB.chargeLevel)")

// Report 3
// Expected: add() appends an entry.
// Actual: does not compile: "cannot use mutating member on immutable value:
// 'self' is immutable". In a struct, self is a constant inside normal methods.
// Rule: a struct method that changes a property must be marked mutating.
// Fix:
struct Logbook {
    var entries: [String] = []
    mutating func add(_ entry: String) {
        entries.append(entry)
    }
}
var logbook = Logbook()
logbook.add("Teleporter installed")
logbook.add("Day 10: incident")
print("Report 3 fixed: \(logbook.entries)")
print("Logbook size: \(logbook.entries.count)")

// Report 4
// snapshot.oxygen = 40 -> error: "cannot assign to property: 'snapshot' is a 'let' constant".
// For a struct, let freezes the whole value, including every property inside it.
// pod.chargeLevel = 10 -> compiles and works. For a class, let freezes only the
// reference (pod can't point to another pod), the object itself is still mutable.
// Fix: use var for the struct.
var fixedSnapshot = CrewSnapshot.rookie(named: "Dana")
fixedSnapshot.oxygen = 40
let fixedPod = TeleportPod(id: "B", chargeLevel: 50)
fixedPod.chargeLevel = 10
print("Report 4 fixed: snapshot \(fixedSnapshot.oxygen), pod \(fixedPod.chargeLevel)")


// MARK: Level 7 · Sealing the Black Box

// class: one recorder shared by everyone who writes to it (a struct would be copied)
// final: nobody can subclass it and override add() to skip the seal check
final class FlightRecorder {
    // private: outside code can't read, replace or clear the list
    private var entries: [String] = []

    // private(set): outside code can read isSealed but can't set it back to false
    internal private(set) var isSealed = false

    // internal: anyone in the module can read the count, but it's read-only
    internal var entryCount: Int {
        entries.count
    }

    // internal: anyone can read the transcript, it's a copy as a String
    internal var transcript: String {
        var text = ""
        for (index, entry) in entries.enumerated() {
            text += "\(index + 1). \(entry)\n"
        }
        return text
    }

    // internal: the only way to add an entry, and it checks the seal first
    @discardableResult
    internal func add(_ entry: String) -> Bool {
        guard isSealed == false else {
            print("Recorder is sealed, rejected: \(entry)")
            return false
        }
        entries.append(entry)
        return true
    }

    // internal: anyone can seal, nobody can unseal (there is no method for it)
    internal func seal() {
        isSealed = true
    }

    // fileprivate: only code in this file (auditTranscript) can get the raw list
    fileprivate func entriesForAudit() -> [String] {
        entries
    }
}

func auditTranscript(of recorder: FlightRecorder) -> String {
    let list = recorder.entriesForAudit()
    return "Audit: \(list.count) entries, sealed: \(recorder.isSealed), last: \(list.last ?? "none")"
}

let recorder = FlightRecorder()
recorder.add("Teleporter test 1 OK")
recorder.add("Day 10: crew transfer")
print(recorder.entryCount)
print(recorder.transcript)
recorder.seal()
recorder.add("Rewrite history")
print(recorder.entryCount)
print(auditTranscript(of: recorder))

// Trying to break it from outside:
// recorder.entries = []
// error: 'entries' is inaccessible due to 'private' protection level
// recorder.entries.removeAll()
// error: 'entries' is inaccessible due to 'private' protection level
// recorder.isSealed = false
// error: cannot assign to property: 'isSealed' setter is inaccessible


// MARK: Finale · Integrity Code

let D = AlarmLevel.level(forTotalMass: A).rawValue
let integrityCode = "\(A)-\(B)-\(C)-\(D)"
print("INTEGRITY CODE: \(integrityCode)")


// MARK: Bonus

// 2. Lifetime experiment
print("Experiment 1: both references inside the block")
do {
    let tempPod = TeleportPod(id: "T-1", chargeLevel: 50)
    let sameTempPod = tempPod
    print("inside block: \(tempPod.id), \(sameTempPod.id)")
}
print("after block 1")
// deinit fires right after "inside block", when the block ends:
// both references were local, so the reference count drops to 0.

print("Experiment 2: one reference kept outside")
var keptPod: TeleportPod?
do {
    let tempPod = TeleportPod(id: "T-2", chargeLevel: 50)
    keptPod = tempPod
    print("inside block: \(tempPod.id)")
}
print("after block 2, pod still alive: \(keptPod?.id ?? "none")")
keptPod = nil
print("after keptPod = nil")
// deinit fires on the line keptPod = nil: leaving the block removed one
// reference, but keptPod still held the pod. Setting it to nil removed the last one.

// 3. Same pod or equal pods
func compare(_ first: TeleportPod, _ second: TeleportPod) -> String {
    if first === second {
        return "same pod (two references to one object)"
    }
    if first.id == second.id && first.chargeLevel == second.chargeLevel
        && first.occupant?.name == second.occupant?.name {
        return "two different pods with equal contents"
    }
    return "two different pods"
}

let record1 = TeleportPod(id: "P-9", chargeLevel: 60)
let record2 = record1
let record3 = TeleportPod(id: "P-9", chargeLevel: 60)
print(compare(record1, record2))
print(compare(record1, record3))

// === can't be used on CrewSnapshot:
// snapX === snapY
// error: argument type 'CrewSnapshot' expected to be an instance of a class
// A struct has no identity, only a value. Every assignment makes a new copy,
// so "is it the same instance?" has no meaning for it.


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. Why did CrewSnapshot get an initializer for free and TeleportPod did not?
    Structs get a memberwise init automatically (if you don't write your own
    init inside the struct). Classes never get one, because with inheritance
    Swift can't know how a subclass should initialize the parent's properties.
    A class only gets a free init() when all stored properties have default
    values. TeleportPod's id and chargeLevel have none, so I wrote init myself.

 2. What does `mutating` do to self, and why do classes never need it?
    In a normal struct method self is a let constant. mutating makes self
    an inout parameter, so the method can change properties or even replace
    self completely (like reviveInMedbay does). It's also why you can't call
    a mutating method on a let struct.
    Classes don't need it because self is a reference: the method changes
    the object it points to, not the reference itself.

 3. In Report 4 both values are `let`. What exactly does `let` freeze?
    Struct: let freezes the whole value. The properties are part of the
    value, so snapshot.oxygen = 40 is an error, even though oxygen is var.
    Class: let freezes only the reference. pod can't be set to another pod,
    but the object it points to can still change: pod.chargeLevel = 10 is fine.

 4. Why must a lazy property be var? When does lazy change behaviour?
    A lazy property has no value after init, it is set later on first access.
    A let must have its value when init finishes, so lazy let is impossible.
    Behaviour example: fullDiagnostics prints "Running full scan..." and
    reads hullIntegrity. If it was a normal property, the scan would run
    during init for every station, even backupStation, and it would capture
    the values at init time. With lazy it runs only if someone asks, and
    it uses the values at the moment of the first access.

 5. private vs fileprivate: where would private be too strict?
    auditTranscript(of:) is a free function outside the class but in the
    same file. It needs the raw entry list. If entriesForAudit() was private,
    only code inside FlightRecorder could call it and the audit function
    wouldn't compile. fileprivate opens it for this file only, and the
    entries array itself stays private. The returned array is a copy,
    so the audit can't change the real log.

 Bonus. On which line does deinit fire, and why can't === be used on
 CrewSnapshot?
    Experiment 1: at the end of the do block, because both references were
    local and disappear together. Experiment 2: on keptPod = nil, because
    keptPod was the last strong reference. ARC destroys the object when the
    reference count becomes 0.
    === checks if two references point to the same object. A struct is
    a value, not an object, so there is nothing to compare by identity.
*/
