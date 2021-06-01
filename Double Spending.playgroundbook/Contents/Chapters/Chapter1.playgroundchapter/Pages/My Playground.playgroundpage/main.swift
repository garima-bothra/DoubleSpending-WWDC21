/*:
 # CREATING GOOFY COIN
 
 Goofy wants your help in setting up his keys and creating a Goofy Coin. Make sure you don't share Goofy's private key 🤫
 
 ## Understanding :
  Why use Goofy's private key to create coins? 🪙
  * Using Goofy's private key to create coin indicates that the transaction is validated by Goofy
 
 ## To Do:
 1. Make sure Goofy's private key is used to create the coin 🪙
 2. Run the playground

Once you're ready, [Click Here](@next) to go to the next page
 */
import AVKit
import  CryptoKit
import SwiftUI
import PlaygroundSupport

let goofy = Goofy(goofyPrivateKey: "GoofyLovesCrypto", goofyPublicKey: "HeyGoofyHere")
createGoofyCoin(goofy: goofy, key: "GoofyLovesCrypto", amount: 40)
    
//#-hidden-code
func createGoofyCoin(goofy: Goofy, key: String, amount: Double) { 
    var coin: GoofyCoin?
    var transaction: GoofyTransaction?
    (coin,transaction) = goofy.createCoin(goofyKey: key, amount: amount)
if coin != nil && transaction != nil  {
    PlaygroundPage.current.setLiveView(NewGoofyCoinView().background(Color.white))
} else {
    PlaygroundPage.current.setLiveView(NoCoinView().background(Color.white))
}
}
struct NewGoofyCoinView: View {
    
    @State var audioPlayer: AVAudioPlayer?
    @State var lock_offset : CGFloat = -UIScreen.main.bounds.height * 0.45
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(uiImage: #imageLiteral(resourceName: "goofyCoin.png"))
                .resizable()
                .frame(width: 200, height: 200)
                .opacity(1)
                .offset(x: 0 ,y:lock_offset)
                .onAppear { 
                    playAudio()
                    let baseAnimation = Animation.easeInOut(duration: 2)
                    return withAnimation(baseAnimation){
                        self.lock_offset = UIScreen.main.bounds.height*0.0
                    }
                }
            Text("Yay! Your Goofy Coin is ready 🥳!")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
    func playAudio() { /// function to play audio
        
        if let audioURL = Bundle.main.url(forResource: "zapsplatCoinDrop", withExtension: "mp3") {
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOf: audioURL) /// make the audio player
                self.audioPlayer?.numberOfLoops = 0 /// Number of times to loop the audio
                self.audioPlayer?.play() /// start playing
                
            } catch {
                print("Couldn't play audio. Error: \(error)")
            }
            
        } else {
            print("No audio file found")
        }
    }
}

struct NoCoinView: View {
    
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
            Text("Oops 😬! Please check your private key!")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center)
        }
    }
}
//#-end-hidden-code
