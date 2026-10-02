// Assignment 2 - Collections

// Easy 1
let fruits = ["grapes", "apple", "peach", "mango", "banana"]
print(fruits[2])

// Easy 2
var favoriteNumbers: Set = [8, 3, 21]
favoriteNumbers.insert(14)
print(favoriteNumbers)

// Easy 3
let languages = ["Swift": 2014, "Python": 1991, "Java": 1995]
print(languages["Swift"] ?? 0)

// Easy 4
var colors = ["red", "green", "blue", "yellow"]
colors[1] = "burgundy"
print(colors)

// Medium 1
let setA: Set = [1, 2, 3, 4]
let setB: Set = [3, 4, 5, 6]
print(setA.intersection(setB))

// Medium 2
var scores = ["Aruzhan": 85, "Timur": 72, "Dana": 90]
scores.updateValue(95, forKey: "Timur")
print(scores)

// Medium 3
let firstArray = ["apple", "banana"]
let secondArray = ["cherry", "date"]
let merged = firstArray + secondArray
print(merged)

// Hard 1
var populations = ["Kazakhstan": 20_000_000, "Japan": 124_000_000, "Spain": 48_000_000]
populations["Canada"] = 41_000_000
print(populations)

// Hard 2
let animals1: Set = ["cat", "dog"]
let animals2: Set = ["dog", "mouse"]
let unionSet = animals1.union(animals2)
let result = unionSet.subtracting(animals2)
print(result)

// Hard 3
let grades = [
    "Dilnaz": [95, 88, 92],
    "Aruzhan": [80, 91, 77]
]
print(grades["Dilnaz"]?[1] ?? 0)
