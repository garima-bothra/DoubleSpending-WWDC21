/*:
 # INTRODUCTION TO GOOFY COINS
 
 ## Preface :

 Digital currency (digital money, electronic money or electronic currency) is any currency, money, or money-like asset that is primarily managed, stored or exchanged on digital computer systems, especially over the internet. The digital currency we will focus on, in this playground is **Cryptocurrency**.
 
 ## Understanding :
 1. What is Goofy Coin?
      * Goofy is here from Disneyland to help us understand some concepts relating to cryptocurrencies. Let us assume, he makes Goofy Coins (a type of **cryptocurrency**). The key points to be noted about Goofy Coin are:
               a. Only Goofy can create new coins
               b. Coin owners can pass on this coin by calling the pay function
 
 2. Why are we using two keys for every user? 🗝
      * Private keys are like digital signatures (or passwords). Only we know our private keys.
      * Public keys are like bank account numbers, you share them so others can deposit money to your account.
 
 ## To Do:
  1. Run the playground
 
 Once you're ready, [Click Here](@next) to go to the next page
 */

//#-hidden-code
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    
    @State var currentImage: UIImage =  #imageLiteral(resourceName: "heyGoofy.png")
    @State var nextButtonText: String = " Next "
    var images: [UIImage] =  [#imageLiteral(resourceName: "Component 1.png"),#imageLiteral(resourceName: "Keys.png"),#imageLiteral(resourceName: "goofyHonestPayment.png")]
    @State var currIndex: Int = 0
    var body: some View {
        VStack {
            Image(uiImage: currentImage)
                .resizable()
                .scaledToFit()
                .padding(20)
                .animation(.easeInOut(duration: 0.5))
            HStack {
                Spacer()
                Button {
                    if currIndex == 2 {
                        PlaygroundPage.current.navigateTo(page: .next)
                    }
                    currIndex += 1
                    self.currentImage = images[currIndex]
                } label: {
                    Text(self.nextButtonText)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .shadow(color: .gray, radius: 2, x: 0, y: 1)
                }
                .padding(20)
            }
        }
    }
}
PlaygroundPage.current.setLiveView(ContentView().background(Color.white))
//#-end-hidden-code
