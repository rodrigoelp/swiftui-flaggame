//

import Foundation
import Combine

func shuffleCountries() -> [Country] {
    return countriesData
        .shuffled()
        .enumerated()
        .filter { $0.offset < 3 }
        .map { $0.element }
}

final class UserData: ObservableObject {
    @Published var countries = shuffleCountries()
    @Published var currentAnswerIndex = Int.random(in: 0...2)

    @Published var score = 0
    @Published var correctAnswers = 0
    @Published var incorrectAnswers = 0

    func registerAnswer(_ answer: Country) -> Bool {
        let correct = countries[currentAnswerIndex]
        let wasCorrect = correct.code == answer.code

        if wasCorrect {
            score += 1
            correctAnswers += 1
        } else {
            score -= 1
            incorrectAnswers -= 1
        }

        return wasCorrect
    }

    func next() {
        countries = shuffleCountries()
        currentAnswerIndex = Int.random(in: 0...2)
    }
}
