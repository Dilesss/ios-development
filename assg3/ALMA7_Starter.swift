// MARK: - =================== STARTER CODE ===================
// MARK: - Do not modify anything in this section

typealias Reading = (sensor: String, value: Int)

/// Splits a string at the first occurrence of the separator.
/// splitOnce("O2:87", by: ":") -> ("O2", "87")
/// splitOnce("hello", by: ":") -> nil
func splitOnce(_ line: String, by separator: Character) -> (String, String)? {
    guard let index = line.firstIndex(of: separator) else { return nil }
    let left = String(line[..<index])
    let right = String(line[line.index(after: index)...])
    return (left, right)
}

let rawLog = [
    "O2:87", "TEMP:-12", "O2:9x", "PRESS:101", "TEMP:abc", "O2:",
    "RAD:3", "O2:64", ":55", "TEMP:31", "PRESS:98", "O2:71",
    "RAD:-1", "TEMP:4", "PRESS:1o2", "O2:90"
]

class Tank {
    var level: Int
    init(level: Int) { self.level = level }
}

class Module {
    let name: String
    var oxygenTank: Tank?
    init(name: String, oxygenTank: Tank?) {
        self.name = name
        self.oxygenTank = oxygenTank
    }
}

class CrewMember {
    let name: String
    let role: String
    let priority: Int      // 1 = evacuated first
    var module: Module?    // nil = in open space
    init(name: String, role: String, priority: Int, module: Module?) {
        self.name = name
        self.role = role
        self.priority = priority
        self.module = module
    }
}

let lab  = Module(name: "Lab",  oxygenTank: Tank(level: 40))
let hab  = Module(name: "Hab",  oxygenTank: Tank(level: 12))
let dock = Module(name: "Dock", oxygenTank: nil)

let crew = [
    CrewMember(name: "Timur",   role: "Engineer",  priority: 3, module: lab),
    CrewMember(name: "Dana",    role: "Scientist", priority: 4, module: dock),
    CrewMember(name: "Aigerim", role: "Commander", priority: 1, module: hab),
    CrewMember(name: "Nurlan",  role: "Pilot",     priority: 2, module: nil)
]

var roster: [String: CrewMember] = [:]
for member in crew { roster[member.name] = member }

print("ALMA-7 systems online: \(rawLog.count) log lines, \(crew.count) crew members.")

// MARK: - ================= END OF STARTER CODE =================


// MARK: - =================== YOUR SOLUTION ===================


// MARK: Level 1 · Decoding Telemetry

// 1.1
func parseReading(_ raw: String) -> Reading? {
    guard let parts = splitOnce(raw, by: ":"),
          parts.0.isEmpty == false,
          let value = Int(parts.1),
          value >= 0 || parts.0 == "TEMP"
    else { return nil }
    return (sensor: parts.0, value: value)
}

print(parseReading("O2:87") as Any)
print(parseReading("TEMP:-12") as Any)
print(parseReading("RAD:-1") as Any)
print(parseReading(":55") as Any)

// 1.2
func parseLog(_ lines: [String]) -> (valid: [Reading], invalidCount: Int) {
    var valid: [Reading] = []
    var invalidCount = 0
    for line in lines {
        if let reading = parseReading(line) {
            valid.append(reading)
        } else {
            invalidCount += 1
        }
    }
    return (valid, invalidCount)
}

let telemetry = parseLog(rawLog)
print("valid: \(telemetry.valid.count), invalid: \(telemetry.invalidCount)")
print(parseLog(["O2:50", "bad", "TEMP:-3"]))

let A = telemetry.invalidCount


// MARK: Level 2 · Analysis

// 2.1
func select(_ readings: [Reading], where isIncluded: (Reading) -> Bool) -> [Reading] {
    var result: [Reading] = []
    for reading in readings {
        if isIncluded(reading) {
            result.append(reading)
        }
    }
    return result
}

func values(of readings: [Reading]) -> [Int] {
    var result: [Int] = []
    for reading in readings {
        result.append(reading.value)
    }
    return result
}

let o2Readings = select(telemetry.valid) { $0.sensor == "O2" }
let tempReadings = select(telemetry.valid) { $0.sensor == "TEMP" }
print(o2Readings)
print(values(of: o2Readings))
print(values(of: tempReadings))

// 2.2
func stats(of values: [Int]) -> (min: Int, max: Int, average: Double)? {
    guard let first = values.first else { return nil }
    var minValue = first
    var maxValue = first
    var sum = 0
    for value in values {
        if value < minValue { minValue = value }
        if value > maxValue { maxValue = value }
        sum += value
    }
    return (minValue, maxValue, Double(sum) / Double(values.count))
}

func stats(_ values: Int...) -> (min: Int, max: Int, average: Double)? {
    stats(of: values)
}

print(stats(3, 8, 1) as Any)
print(stats() as Any)
print(stats(of: []) as Any)

let o2Stats = stats(of: values(of: o2Readings))
print(o2Stats as Any)

let B = Int(o2Stats?.average ?? 0)

// 2.3 · The Closure Ladder
let readings = telemetry.valid

let sorted1 = readings.sorted(by: { (a: Reading, b: Reading) -> Bool in
    return a.value > b.value
})
let sorted2 = readings.sorted(by: { a, b in return a.value > b.value })
let sorted3 = readings.sorted(by: { a, b in a.value > b.value })
let sorted4 = readings.sorted(by: { $0.value > $1.value })
let sorted5 = readings.sorted { $0.value > $1.value }

let ladderResult = values(of: sorted1)
let allSame = ladderResult == values(of: sorted2)
    && ladderResult == values(of: sorted3)
    && ladderResult == values(of: sorted4)
    && ladderResult == values(of: sorted5)
print(ladderResult)
print("All 5 sorts match: \(allSame)")


// MARK: Level 3 · Temperature Stabilization

// 3.1
func heatUp(_ t: Int) -> Int { t + 5 }
func coolDown(_ t: Int) -> Int { t - 3 }
func hold(_ t: Int) -> Int { t }

func chooseProtocol(for temp: Int) -> (Int) -> Int {
    if temp < 18 {
        return heatUp
    } else if temp > 24 {
        return coolDown
    }
    return hold
}

print(heatUp(10), heatUp(-5))
print(coolDown(30), coolDown(25))
print(hold(20), hold(18))
print(chooseProtocol(for: 10)(10))
print(chooseProtocol(for: 30)(30))
print(chooseProtocol(for: 21)(21))

// 3.2
func runUntilStable(from start: Int, maxSteps: Int = 10) -> (finalTemp: Int, steps: Int, isStable: Bool) {
    var temp = start
    var steps = 0
    while (temp < 18 || temp > 24) && steps < maxSteps {
        let action = chooseProtocol(for: temp)
        temp = action(temp)
        steps += 1
    }
    return (temp, steps, temp >= 18 && temp <= 24)
}

print(runUntilStable(from: 31))
print(runUntilStable(from: -100, maxSteps: 5))
print(runUntilStable(from: 20))

let lowestTemp = stats(of: values(of: tempReadings))?.min ?? 0
print("lowest temp: \(lowestTemp)")

let C = runUntilStable(from: lowestTemp).steps


// MARK: Level 4 · The Crew

// 4.1
func oxygenLevel(of member: CrewMember) -> Int? {
    member.module?.oxygenTank?.level
}

print(oxygenLevel(of: crew[0]) as Any)
print(oxygenLevel(of: crew[1]) as Any)

// 4.2
func status(of member: CrewMember) -> String {
    guard let level = oxygenLevel(of: member) else {
        let place = member.module?.name ?? "open space"
        return "\(member.name): no data (\(place))"
    }
    if level < 20 {
        return "\(member.name): \(level)% CRITICAL"
    }
    return "\(member.name): \(level)% OK"
}

for member in crew {
    print(status(of: member))
}

// 4.3
@discardableResult
func transferOxygen(from source: inout Int, to target: inout Int, amount: Int) -> Int {
    guard amount > 0 else { return 0 }
    let freeSpace = 100 - target
    let moved = max(0, min(amount, source, freeSpace))
    source -= moved
    target += moved
    return moved
}

var testSource = 50
var testTarget = 90
print(transferOxygen(from: &testSource, to: &testTarget, amount: 30))
print(transferOxygen(from: &testSource, to: &testTarget, amount: -5))
var smallSource = 7
var emptyTarget = 0
print(transferOxygen(from: &smallSource, to: &emptyTarget, amount: 20)) // 7

if let labTank = lab.oxygenTank, let habTank = hab.oxygenTank {
    let moved = transferOxygen(from: &labTank.level, to: &habTank.level, amount: 30)
    print("Moved \(moved): Lab = \(labTank.level), Hab = \(habTank.level)")
}

let D = hab.oxygenTank?.level ?? 0

// 4.4
func evacuationOrder(_ names: String..., roster: [String: CrewMember]) -> [String] {
    var found: [CrewMember] = []
    for name in names {
        guard let member = roster[name] else {
            print("Unknown crew member: \(name)")
            continue
        }
        found.append(member)
    }
    let sortedMembers = found.sorted { $0.priority < $1.priority }
    var result: [String] = []
    for member in sortedMembers {
        result.append(member.name)
    }
    return result
}

print(evacuationOrder("Dana", "Ghost", "Aigerim", "Timur", roster: roster))
print(evacuationOrder("Nurlan", "Timur", "Nobody", roster: roster))


// MARK: Level 5 · The Saboteur's Logbook

/*
func reportOxygen(for member: CrewMember) -> String {
    let tank = member.module!.oxygenTank!
    // Bug 1: member.module! -> Nurlan has no module (nil), app crashes.
    // Bug 2: oxygenTank! -> Dana is in Dock, Dock has no tank (nil), crash.
    return "\(member.name): \(tank.level)%"
}

func firstCritical(in crew: [CrewMember]) -> String {
    var result: String?
    for member in crew {
        if oxygenLevel(of: member)! < 20 {
            // Bug 3: oxygenLevel is nil for Dana and Nurlan -> crash.
            //        Dana is 2nd in the array, so it crashes before reaching Aigerim.
            result = member.name
            // Bug 4 (logic): no early exit, so result is overwritten by every
            //        next critical member -> it returns the LAST critical one,
            //        not the first. Starter data has only one critical (Aigerim),
            //        so this is invisible.
        }
    }
    return result!
    // Bug 5: if nobody is critical, result is nil -> crash.
    //        This happens after the oxygen transfer (Hab = 42).
    // Bug 6: return type String can't express "nobody is critical",
    //        it should be String?.
}
*/

func reportOxygen(for member: CrewMember) -> String {
    guard let tank = member.module?.oxygenTank else {
        return "\(member.name): no data"
    }
    return "\(member.name): \(tank.level)%"
}

func firstCritical(in crew: [CrewMember]) -> String? {
    for member in crew {
        if let level = oxygenLevel(of: member), level < 20 {
            return member.name
        }
    }
    return nil
}

for member in crew {
    print(reportOxygen(for: member))
}
print(firstCritical(in: crew) ?? "nobody is critical")

// test for the logic bug: saboteur's version returns TestB here
let testA = CrewMember(name: "TestA", role: "Test", priority: 5,
                       module: Module(name: "T1", oxygenTank: Tank(level: 5)))
let testB = CrewMember(name: "TestB", role: "Test", priority: 6,
                       module: Module(name: "T2", oxygenTank: Tank(level: 10)))
let testNoData = CrewMember(name: "TestC", role: "Test", priority: 7, module: nil)

print(firstCritical(in: [testNoData, testA, testB]) ?? "nobody")
print("Logic bug fixed: \(firstCritical(in: [testNoData, testA, testB]) == "TestA")")
print("Empty crew: \(firstCritical(in: []) ?? "nobody")")


// MARK: Finale · Launch Code

let launchCode = "\(A)-\(B)-\(C)-\(D)"
print("LAUNCH CODE: \(launchCode)")


// MARK: Bonus

func makeAlarm(threshold: Int) -> (Int) -> Bool {
    var count = 0
    return { level in
        guard level < threshold else { return false }
        count += 1
        print("Alarm #\(count)")
        return true
    }
}

let alarm = makeAlarm(threshold: 20)
print(alarm(12))
print(alarm(40))
print(alarm(5))

let otherAlarm = makeAlarm(threshold: 50)
print(otherAlarm(30))


// MARK: - ================= DEFENSE QUESTIONS =================
/*
 1. guard let vs if let beyond syntax:
    With guard let the unwrapped value stays available after the guard,
    for the rest of the function, and the else block must leave the scope
    (return / continue / break). With if let the value only exists inside
    the braces. So guard is for "early exit": check the bad cases first,
    and the main code stays flat.
    Example: parseReading with if let would turn into a pyramid:
        if let parts = splitOnce(raw, by: ":") {
            if parts.0.isEmpty == false {
                if let value = Int(parts.1) {
                    if value >= 0 || parts.0 == "TEMP" {
                        return (parts.0, value)
                    }
                }
            }
        }
        return nil
    4 levels of nesting instead of one guard.

 2. Why can't you pass [Int] to stats(_ values: Int...)?
    Int... means "any number of separate Int arguments". Inside the function
    Swift packs them into [Int], but at the call site it still expects Ints,
    not an array. stats(someArray) would mean one argument of type [Int],
    which is a type mismatch. Swift has no way to "spread" an array into
    variadic arguments, that's why we have stats(of:) and the variadic
    version just calls it.

 3. Why doesn't transferOxygen(from: &x, to: &x, amount: 5) compile?
    Swift has exclusive access to memory: while a function has inout access
    to a variable, no one else can access the same variable. Passing x twice
    gives two overlapping inout accesses -> compile error.
    It prevents aliasing bugs: source and target would be the same memory,
    so "source -= 5; target += 5" would read and write one value in a
    confusing way and the result would depend on the order of operations.

 4. Why doesn't oxygenLevel(of: dana) ?? "no data" compile?
    The ?? operator needs the default value to be the same type as what is
    inside the optional. oxygenLevel returns Int?, so the default must be Int,
    but "no data" is a String. Fix: unwrap first and convert to String, e.g.
        if let level = oxygenLevel(of: dana) { "\(level)%" } else { "no data" }
    or use a number as default: oxygenLevel(of: dana) ?? 0.

 5. Full type of chooseProtocol and how to read it:
    (Int) -> (Int) -> Int
    The arrow groups from the right, so it is (Int) -> ((Int) -> Int):
    "a function that takes an Int (the temperature) and returns
    another function, which takes an Int and returns an Int".
    That's why chooseProtocol(for: 10)(10) works: the first call returns
    heatUp, the second call applies it.

 Bonus. Where does the alarm counter live after makeAlarm returns?
    count is captured by the closure. Normally a local variable disappears
    when the function returns, but because the closure uses it, Swift moves
    it to the heap (in a small box) and the closure keeps a reference to it.
    So count lives as long as the closure (alarm) lives. Every call of
    makeAlarm creates a new count, so different alarms have separate counters.
*/
