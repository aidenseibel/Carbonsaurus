//
//  quiz.swift
//  Carbonsaurus
//
//  Created by Aiden Seibel on 2/25/24.
//

import Foundation

struct Quiz {
    var question: String
    var answerIndex: Int
    var choices: [String]
}

var exampleQuizzes: [Quiz] = [
    Quiz(question: "Which gas is primarily responsible for trapping heat in the Earth's atmosphere?", answerIndex: 2, choices: ["Oxygen", "Nitrogen", "Carbon dioxide", "Helium"]),
    Quiz(question: "What is the main cause of the increase in atmospheric carbon dioxide?", answerIndex: 2, choices: ["Volcanic eruptions", "Deforestation", "Burning fossil fuels", "Cattle farming"]),
    Quiz(question: "Which of the following is NOT a potential consequence of climate change?", answerIndex: 1, choices: ["Rising sea levels", "Increased biodiversity", "More frequent extreme weather events", "Melting glaciers"]),
    Quiz(question: "Which international agreement aims to combat climate change by reducing greenhouse gas emissions?", answerIndex: 0, choices: ["Paris Agreement", "Kyoto Protocol", "Geneva Convention", "Rio Declaration"]),
    Quiz(question: "What is the main source of methane emissions contributing to climate change?", answerIndex: 0, choices: ["Agriculture (livestock)", "Industrial processes", "Transportation", "Waste management"]),
    Quiz(question: "What is the primary driver of deforestation, which contributes to climate change?", answerIndex: 2, choices: ["Urbanization", "Mining", "Agriculture", "Wildlife conservation"]),
    Quiz(question: "Which of the following is a consequence of ocean acidification caused by climate change?", answerIndex: 1, choices: ["Increase in coral reef growth", "Decrease in marine biodiversity", "Rise in ocean pH levels", "Expansion of polar ice caps"]),
    Quiz(question: "What is the term for the phenomenon where melting Arctic ice leads to a feedback loop that accelerates warming?", answerIndex: 1, choices: ["Polar vortex", "Albedo effect", "Ice sheet collapse", "Tundra thawing"]),
    Quiz(question: "Which renewable energy source harnesses the power of the sun?", answerIndex: 1, choices: ["Wind energy", "Solar energy", "Hydroelectric energy", "Geothermal energy"]),
    Quiz(question: "What is the primary greenhouse gas emitted from burning natural gas?", answerIndex: 0, choices: ["Methane", "Nitrous oxide", "Ozone", "Chlorofluorocarbons"]),
    Quiz(question: "Which of the following is a human activity that reduces carbon dioxide in the atmosphere?", answerIndex: 2, choices: ["Using air conditioning", "Burning coal", "Planting trees", "Driving cars"]),
    Quiz(question: "What is a key indicator of climate change affecting the polar regions?", answerIndex: 3, choices: ["Increased snowfall", "Decreased sunlight", "More frequent hurricanes", "Melting ice caps"]),
    Quiz(question: "What term describes the long-term changes in temperature, precipitation, and other atmospheric conditions?", answerIndex: 1, choices: ["Weather", "Climate", "Seasons", "Ecosystems"])
]
