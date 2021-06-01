
// Code inside modules can be shared between pages and other source files.
import Foundation
import CryptoKit

public class Coin: Identifiable {
    var cID: String = UUID().uuidString
    var amount: Double 
    init(money: Double){
        amount = money
    }
}

public class User: Equatable {
    var userID = UUID()//Public key
    var publicKey: String
    var privateKey: String
    public func getUserID() -> UUID {
        return userID
    }
    public init(UserPublicKey: String, UserPrivateKey: String){
        
        publicKey = UserPublicKey
        privateKey = UserPrivateKey
    }
    init(){
        privateKey = ""
        publicKey = ""
    }
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userID == rhs.userID &&
            lhs.publicKey == rhs.publicKey &&
            lhs.privateKey == rhs.privateKey
    }
}

class Transaction {
    var transactionID: UUID = UUID()
    var sender: User
    var receiver: User
    var coinID: Coin = Coin(money: 0)
    var previousHash = SHA256.hash(data: Data())
    init(sendUser: User, receiveUser: User, coin: Coin, previousTransactionHash: SHA256Digest){
        sender = sendUser
        receiver = receiveUser
        coinID = coin
        previousHash = previousTransactionHash
    }
}

class Block {
    var blockID: Int = -1
    var transactions: [Transaction] = []
    var previousBlock: Int = -1
    init(currentBlockId: Int, previousBlockId: Int) {
        blockID = currentBlockId
        previousBlock = previousBlockId
    }
    init(){
        
    }
}

class Blockchain {
    var blocks: [Block] = []
}

public class Scrooge {
    public var userId: User
    var privateKey: String
    var publicKey: String
    var blockchain = Blockchain()
    var currentBlock = Block()
    var coinsCreated: [String: Coin]
    public init(scroogePrivateKey: String,scroogePublicKey: String ) {
        let scrooge = User(UserPublicKey: scroogePublicKey, UserPrivateKey: scroogePrivateKey)
        self.userId = scrooge
        self.privateKey = scroogePrivateKey
        self.publicKey = scroogePublicKey
        coinsCreated = [:]
        let genesisBlock = Block(currentBlockId: 0, previousBlockId: -1)
        genesisBlock.transactions.append(Transaction(sendUser: scrooge, receiveUser: scrooge, coin: Coin(money: 0), previousTransactionHash: SHA256.hash(data: Data())))
        blockchain.blocks.append(genesisBlock)
    }
    
    func publishBlock(){
        if currentBlock.transactions.count == 1 {
            let blockID = blockchain.blocks[blockchain.blocks.count - 1].blockID 
            currentBlock.previousBlock = blockID
            currentBlock.blockID = blockID + 1
            blockchain.blocks.append(currentBlock)
            currentBlock = Block()
        }
    }
    public func createCoin(amount: Double, scroogePrivateKey: String)-> String {
        if scroogePrivateKey == privateKey {
            var coin = Coin(money: amount)
            var transaction = Transaction(sendUser: userId, receiveUser: userId, coin: coin, previousTransactionHash: SHA256.hash(data: Data()))
            currentBlock.transactions.append(transaction)
            publishBlock()
            coinsCreated[coin.cID] = coin
            //return coin.cID
            return coin.cID
        }else {
            print("Private key does not match")
        }
        return ""
    }
    
    //MARK: 
    
    public func payCoin(coinID: String, sender: User, receiver: User, receiverPublicKey: String, senderPrivateKey: String)-> Bool{
        if(sender.privateKey == senderPrivateKey) && (receiver.publicKey == receiverPublicKey) {
            var prevBlockId: Int
            var prevTransactionId, owner: UUID?
            (prevBlockId, prevTransactionId, owner) = findPreviousTransaction(coinId: coinID)
            guard let ownerId = owner, let prevTransaction = prevTransactionId else {
                return false
            }
            if ownerId == sender.getUserID(){
                guard let coin = coinsCreated[coinID] else { return false }
                guard let data = prevTransaction.uuidString.data(using: .utf8) else { return false}
                var transaction = Transaction(sendUser: sender, receiveUser: receiver, coin: coin, previousTransactionHash: SHA256.hash(data: data))
                currentBlock.transactions.append(transaction)
                publishBlock()
                return true
            }
        }
        return false
    }
    
    public func findPreviousTransaction(coinId: String)-> (Int, UUID?, UUID?) {
        var n = blockchain.blocks.count - 1
        while(n>0){
            var transactionsCount = blockchain.blocks[n].transactions.count - 1
            while(transactionsCount >= 0){
                let transaction = blockchain.blocks[n].transactions[transactionsCount]
                if transaction.coinID.cID == coinId {
                    let blockID = blockchain.blocks[n].blockID 
                    return (blockID, transaction.transactionID, transaction.receiver.getUserID())
                }
                transactionsCount -= 1
            }
            n -= 1
        }
        return (-1,UUID(uuidString: ""), UUID(uuidString: "") )
    }
}
