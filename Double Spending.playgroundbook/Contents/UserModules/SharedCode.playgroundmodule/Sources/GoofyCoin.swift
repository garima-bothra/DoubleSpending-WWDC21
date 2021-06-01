import SwiftUI
import Foundation
import CryptoKit

public class GoofyCoin {
    
    var coinId: UUID
    var amount: Double
    
    public init(amount: Double){
        self.coinId = UUID()
        self.amount = amount
    }
    var verifiedHashes: [SHA256Digest] = []
    
    public func verifyTransaction(transaction : GoofyTransaction)-> Bool{
        guard let data = transaction.transactionID.uuidString.data(using: .utf8) else { return false }
        let hash = SHA256.hash(data: data)
        if self.verifiedHashes.contains(hash) {
            return true
        } else { 
        return false
        }
    }
    
    public func payCoin(oldOwner: User, newOwner: User, senderPrivateKey: String, receiverPublicKey: String, previousTransaction: GoofyTransaction) -> GoofyTransaction? {
        if (oldOwner.privateKey == senderPrivateKey) && (newOwner.publicKey == receiverPublicKey) && (verifyTransaction(transaction: previousTransaction)) && previousTransaction.receiver == oldOwner {
            
            guard let data = previousTransaction.transactionID.uuidString.data(using: .utf8) else { return nil }
                let hash = SHA256.hash(data: data)
            let transaction = GoofyTransaction(sendUser: oldOwner, receiveUser: newOwner, coin: self, previousTransactionHash: hash)
            guard let transactionData = previousTransaction.transactionID.uuidString.data(using: .utf8) else { return nil }
            let newHash = SHA256.hash(data: data)
            verifiedHashes.append(newHash)
            return transaction
        }
        return nil
    }
}

public class GoofyTransaction {
    var transactionID: UUID = UUID()
    var coinID: GoofyCoin = GoofyCoin(amount: 0)
    var sender: User
    var receiver: User
    var previousHash = SHA256.hash(data: Data())
    init(sendUser: User, receiveUser: User, coin: GoofyCoin, previousTransactionHash: SHA256Digest){
        coinID = coin
        sender = sendUser
        receiver = receiveUser
        previousHash = previousTransactionHash
    }
}

public class Goofy {
    public var goofy: User
    public init(goofyPrivateKey: String,goofyPublicKey: String ) {
        goofy = User(UserPublicKey: goofyPublicKey, UserPrivateKey: goofyPrivateKey)
    }
    public func createCoin(goofyKey: String, amount: Double) -> (GoofyCoin?,GoofyTransaction?) {
        if goofy.privateKey == goofyKey {
            var coin = GoofyCoin(amount: amount)
            let transaction = GoofyTransaction(sendUser: goofy, receiveUser: goofy, coin: coin, previousTransactionHash: SHA256.hash(data: Data()))
            guard let data = transaction.transactionID.uuidString.data(using: .utf8) else { return (nil,nil) }
            let hash = SHA256.hash(data: data)
            coin.verifiedHashes.append(hash)
            return (coin,transaction)
    } 
        return (nil,nil)
    }
}

