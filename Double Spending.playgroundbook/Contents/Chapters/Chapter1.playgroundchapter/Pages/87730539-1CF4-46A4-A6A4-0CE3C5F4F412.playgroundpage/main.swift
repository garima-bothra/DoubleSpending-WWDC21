/*:
 # CONCLUSION
 
 Yayay!! 🥳 You made it to the end of this playground. Hope you learnt something new about Double Spending and how to solve it. We still have a little problem though.
 
 ## Understanding:
1. What if our Scrooge was dishonest?
      * If the Scrooge is dishonest, it might validate transactions that use coins that are already spent, i.e. **allow Double Spending**
      * It could also invalidate your valid transactions
 2. How to fix it?
      * To fix this, we can use a Peer-to-Peer network that collectively validates each transaction. How? By a majority rule. The transactions that are validated by equal to or more than 51% of all the people on the network, is considered valid else invalid. This solution was proposed by **Satoshi Nakamoto** in 2008 in his paper *Bitcoin: A Peer-to-Peer Electronic Cash System*. Since then, this solution is widely adopted in the implementation of various cryptocurrencies.
 
 NOTE: **Bitcoin** was the first cryptocurrency released in 2009
 
 ## To Do:
  1. Run the playground
 
 ## Conclusion
 
 We learned what is **Double Spending**, loopholes in Goofy and Scrooge  coins and how **Bitcoin** overcomes them. Can you think of loopholes in Bitcoin?
 
 ( **HINT:** Who makes sure the network is honest? )
 */
//#-hidden-code
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    
    @State var currentImage: UIImage =  #imageLiteral(resourceName: "dishonestScrooge-2.png")
    @State var nextButtonVisible: Double = 1.0
    var images: [UIImage] =  [#imageLiteral(resourceName: "dishonestScrooge-2.png"),#imageLiteral(resourceName: "p2pNetwork.png") ]
    @State var currIndex: Int = 0
    var body: some View {
        VStack {
            Image(uiImage: currentImage)
                .resizable()
                .scaledToFit()
                .padding(20)
                .animation(.easeInOut(duration: 0.25))
            HStack {
                Spacer()
                Button {
                    if currIndex == 0 {
                        currIndex += 1
                        nextButtonVisible = 0.0
                        self.currentImage = images[currIndex]
                    }
                } label: {
                    Text(" Next ")
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .shadow(color: .gray, radius: 2, x: 0, y: 1)
                        .opacity(nextButtonVisible)
                }
                .padding(20)
            }
        }
    }
}
PlaygroundPage.current.setLiveView(ContentView().background(Color.white))
//#-end-hidden-code
