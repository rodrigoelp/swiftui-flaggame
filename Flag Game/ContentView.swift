//

import SwiftUI

struct ContentView: View {
    var countries = countriesData
        .shuffled()
        .enumerated()
        .filter({ $0.offset < 3 })
        .map({ $0.element })
    
    var answerIndex = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
                VStack(alignment: .center, spacing: 8) {
                    Text("Which flag belongs to: \(countries[answerIndex].name)")
                    ForEach(countries, id: \Country.code) { country in
                        country.image
                            .border(Color.black, width: 2)
                            .onTapGesture {
                                self.flagTapped(country)
                        }
                    }
            }
                .navigationBarTitle(Text("Score: \($score.value)"))
                .alert(isPresented: $showAlert) {
                    Alert(title: Text($alertTitle.value), dismissButton: .default(Text("Continue")))
                }
        }
    }
    
    func flagTapped(_ country: Country) {
        let answerCountry = countries[answerIndex]
        if answerCountry.code == country.code {
            score += 1
            alertTitle = "You are right!"
        } else {
            score -= 1
            alertTitle = "Close but not cigar 😕"
        }
        showAlert = true
    }
}

extension Country {
    var image: Image {
        Image(self.imageName)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
