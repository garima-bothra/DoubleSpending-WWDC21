/*:
 # PAYING WITH GOOFY COIN
 
 ## Understanding :
 1. Why use sender's private key and receiver's public key when sender sends receiver Goofy Coins?
        * Receiver's public key is used to identify receiver and sender's private key is used to validate the transaction
 2. How does the payment process work?
       * Every valid transaction is hashed and stored
       * When Goofy wants to pay Bob, he asks Bob for his public key and provides Bob with the last transaction data structure (in this case, coinCreationTransaction)
       * It is checked if the hash of this transaction is included in the verified hashes and accordingly, the transaction is validated or not
       * If validated, transaction is successful and Bob gets a data structure that proves he is the new owner
 
 ## To Do:
  1. Fill out all keys correctly and make a successful payment 🧾 💸
  2. Run the playground 💨

 Once you're ready, [Click Here](@next) to go to the next page
 */
import SwiftUI
import CryptoKit
import PlaygroundSupport

let goofy = Goofy(goofyPrivateKey: "ILovePizza", goofyPublicKey: "ILoveApple")
let bob = User(UserPublicKey: "PlutoTheDog", UserPrivateKey: "BobTheBuilder")

var coin: GoofyCoin?
var coinCreationTransaction, transaction: GoofyTransaction?
var paymentStatus: Bool = false
(coin, coinCreationTransaction) = goofy.createCoin(goofyKey: "????", amount: 40.0)
if coin != nil && coinCreationTransaction != nil {
    transaction = coin!.payCoin(oldOwner: goofy.goofy, newOwner: bob, senderPrivateKey: "????", receiverPublicKey: "????", previousTransaction: coinCreationTransaction!)
   // transaction = coin!.payCoin(oldOwner: goofy.goofy, newOwner: bob, senderPrivateKey: "????", receiverPublicKey: "????", previousTransaction: coinCreationTransaction!) //Uncomment to test Double Spending
}

//#-hidden-code
if transaction != nil {
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
            Text("Oops! Your transaction has failed!")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
struct ContentView: View {
    @State public var lock_offset : CGFloat = -UIScreen.main.bounds.height * 0.15
    var body: some View {
        VStack {
            Image(uiImage: #imageLiteral(resourceName: "goofysmall.png"))
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
