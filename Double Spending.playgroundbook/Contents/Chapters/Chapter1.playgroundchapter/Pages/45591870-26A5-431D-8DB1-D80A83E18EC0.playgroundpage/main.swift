/*:
 # INTRODUCTION TO SCROOGE COIN
 ## Understanding :
 1. Why **not** Goofy Coin?
      * For Goofy coins, a previous owner could share an old transaction and pay the same coin as many times as he/she/they want. Paying one coin more than once in this fashion is called **Double Spending**.
 2. How does Scrooge fix this problem?
      * Scrooge is a trusted body like a bank that creates the coins and pays it to others. Just like banks, it also checks every transaction and maintains a transaction history. Hence, when a coin owner tries Double Spending, the Scrooge easily catches them and the transaction is invalidated.
 
 ## To Do:
  1. Run the playground

 Once you're ready, [Click Here](@next) to go to the next page
 */
//#-hidden-code
import SwiftUI
import PlaygroundSupport

struct ContentView: View {
    
    @State var currentImage: UIImage =  #imageLiteral(resourceName: "dishonestIllustration.png")
    @State var nextButtonText: String = " Next "
    var images: [UIImage] =  [#imageLiteral(resourceName: "goofy.png"),#imageLiteral(resourceName: "scroogeHelp.png"),#imageLiteral(resourceName: "scroogeCoinsIntro.png") ]
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
