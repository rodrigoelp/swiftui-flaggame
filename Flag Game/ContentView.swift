//

import SwiftUI

struct ContentView: View {
    var countries = countriesData
        .shuffled()
        .enumerated()
        .filter({ $0.offset < 3 })
        .map({ $0.element })
    
    var body: some View {
        VStack {
            ForEach(countries, id: \Country.code) { country in
                Text(country.name)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
