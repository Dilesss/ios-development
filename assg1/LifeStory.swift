// Assignment 1 - My life story

// Step 1
let firstName = "Dilnaz"
let lastName = "Yessenkyzy"
let birthYear = 2006
let currentYear = 2026
let age = currentYear - birthYear
let isStudent = true
let height = 1.65
let city = "Almaty"
let university = "KBTU"
let languages = ["Kazakh", "Russian", "English", "Spanish"]

// Step 2
let hobby = "baking"
let otherHobbies = ["planning", "playing chess"]
let numberOfHobbies = otherHobbies.count + 1
let isHobbyCreative = true
let favoriteNumber = 8
let favoriteColors = ["burgundy", "navy blue"]
let likesCoffee = false

let 🧁 = "🧁"
let 👑 = "♟"
let 🎯 = "In the future, I want to build my own IT company 💻🚀."

// Step 3
let studentText = isStudent ? "I am a student at \(university)." : "I am not a student."
let creativeText = isHobbyCreative ? "which is a creative hobby" : "which is not a creative hobby"
let coffeeText = likesCoffee ? "I love coffee." : "I don't drink coffee."

var lifeStory = "My name is \(firstName) \(lastName). I am \(age) years old, born in \(birthYear). "
lifeStory += "I live in \(city) and I am \(height) m tall. \(studentText) "
lifeStory += "I speak \(languages.count) languages: \(languages.joined(separator: ", ")). "
lifeStory += "I enjoy \(hobby) \(🧁), \(creativeText). "
lifeStory += "I have \(numberOfHobbies) hobbies: \(hobby), \(otherHobbies.joined(separator: " and ")) \(👑). "
lifeStory += "My favorite number is \(favoriteNumber) and my favorite colors are \(favoriteColors.joined(separator: " and ")). "
lifeStory += coffeeText

// Bonus
let futureGoals = 🎯
lifeStory += " " + futureGoals

// Step 4
print(lifeStory)
