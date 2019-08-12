import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData

    @State private var showAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 8) {
                Text("Which flag belongs to:")
                Text(userData.countries[userData.currentAnswerIndex].name)
                    .font(.largeTitle)
                    .padding(.bottom, 24)
                
                ForEach(userData.countries, id: \Country.code) { country in
                    country.image
                        .resizable()
                        .frame(width: 250)
                        .scaledToFit()
                        .border(Color.black, width: 2)
                        .onTapGesture {
                            self.flagTapped(country)
                    }
                }
            }
            .navigationBarTitle(Text("Score: \(userData.score)"))
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), dismissButton: .default(Text("Continue")) {
                    self.userData.next()
                })
            }
        }
    }
    
    func flagTapped(_ country: Country) {
        let wasCorrect = userData.registerAnswer(country)
        if wasCorrect {
            alertTitle = "You are right!"
        } else {
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
        .environmentObject(UserData())
    }
}
#endif
