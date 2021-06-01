/*:
 # PAYING WITH SCROOGE COIN
 
 ## Understanding :
 1. How does Scrooge prevent Double Spending?
       * Scrooge publishes a **blockchain** containing **all transactions**. When someone tries to make a transaction, Scrooge verifies the transaction using the published blockchain. If the transaction is appropriate, it is validated, else not.
 ## To Do:
  1. Fill out all keys correctly and make a successful payment 🧾 💸
  2. Run the playground 💨
  3. Try uncommenting the last line of code with correct keys and run again (**Test Double Spending**)

 Once you're ready, [Click Here](@next) to go to the next page
 */
var scrooge = Scrooge(scroogePrivateKey: "Mickey", scroogePublicKey: "Mouse")
let coin = scrooge.createCoin(amount: 100, scroogePrivateKey: "????")
var bob = User(UserPublicKey: "bobPublic", UserPrivateKey: "bobPrivate")
var alice = User(UserPublicKey: "AlPublic", UserPrivateKey: "AlPrivate")
var paymentStatus = scrooge.payCoin(coinID: coin, sender: scrooge.userId, receiver: alice, receiverPublicKey: "????", senderPrivateKey: "????")

//paymentStatus = scrooge.payCoin(coinID: c, sender: alice, receiver: bob, receiverPublicKey: "????", senderPrivateKey: "????")

//#-hidden-code
import SwiftUI
import PlaygroundSupport

if paymentStatus {
    var view = ContentView()
    PlaygroundPage.current.setLiveView(view.background(Color.white))
} else {
    PlaygroundPage.current.setLiveView(NoPayView().background(Color.white))
}

struct NoPayView: View {
    @State var frameSize : CGFloat = UIScreen.main.bounds.width * 0.1
    var body: some View {
        VStack(spacing: 20) {
            
            Image(uiImage: #imageLiteral(resourceName: "no money.png"))
                .resizable()
                .frame(width: frameSize, height: frameSize)
                .opacity(1)
                .onAppear { 
                    let baseAnimation = Animation.easeInOut(duration: 3).delay(1)
                    return withAnimation(baseAnimation){
                        self.frameSize *= 2
                    }
                }
            Text("Oops 😬! Please check your private key! Or are you trying to Double Spend?")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)
        }
        
    }
}
struct ContentView: View {
    @State public var lock_offset : CGFloat = -UIScreen.main.bounds.height * 0.15
    var body: some View {
        VStack {
            Image(uiImage: #imageLiteral(resourceName: "alice.png"))
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.2)
            ZStack { 
                Rectangle()
                    .fill(Color.blue)
                    .border(Color.black, width: 1)
                    .frame(width: 18, height: UIScreen.main.bounds.height*0.4)
                Image(uiImage: #imageLiteral(resourceName: "scroogeCoin.png"))
                    .resizable()
                    .frame(width: 75, height: 75)
                    .opacity(1)
                    .offset(x: 0 ,y:lock_offset)
                    .onAppear { 
                        let baseAnimation = Animation.easeInOut(duration: 3).delay(1)
                        return withAnimation(baseAnimation){
                            self.lock_offset = UIScreen.main.bounds.height*0.15
                        }
                    }
            }
            Image(uiImage:#imageLiteral(resourceName: "Pluto.png"))
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.2)
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
    }
}
//#-end-hidden-code
