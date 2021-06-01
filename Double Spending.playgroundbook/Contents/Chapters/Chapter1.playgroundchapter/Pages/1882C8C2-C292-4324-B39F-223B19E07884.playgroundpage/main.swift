/*:
 # CREATING SCROOGE COIN
 
 Scrooge also wants your help in setting up his keys and creating a Scrooge Coin. Make sure you don't share his private key either 🤫
 
 ## To Do:
 1. Make sure Scrooge's private key is used to create the coin 🪙
 2. Run the playground

Once you're ready, [Click Here](@next) to go to the next page
*/
import SwiftUI
import AVKit
import PlaygroundSupport

var scrooge = Scrooge(scroogePrivateKey: "Donald", scroogePublicKey: "Duck")
let coin = scrooge.createCoin(amount: 100, scroogePrivateKey: "?????")


//#-hidden-code
PlaygroundPage.current.setLiveView(NewScroogeCoinView().background(Color.white))
if coin == "" {
    PlaygroundPage.current.setLiveView(NoScroogeCoinView().background(Color.white))
}


struct NewScroogeCoinView: View {
    
    @State var audioPlayer: AVAudioPlayer?
    @State var lock_offset : CGFloat = -UIScreen.main.bounds.height * 0.45
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(uiImage: #imageLiteral(resourceName: "scroogeCoin.png"))
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
            Text("Yay! Your Scrooge Coin is ready 🥳!")
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

struct NoScroogeCoinView: View {
    
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
