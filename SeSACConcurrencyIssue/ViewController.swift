//
//  ViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by andev on 11/19/25.
//

import UIKit


class ViewController: UIViewController {
    
    var nickname = "고래밥"
    
    //mutex
    let nicknameLock = NSLock()
    
    //semaphore
    let nicknameSemaphore = DispatchSemaphore(value: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        //datarace()
        //mutex()
        semaphore()
    }

    func datarace() {
        
        print(">>", nickname)
        DispatchQueue.global().async {
            self.nickname = "칙촉"
        }
        
        DispatchQueue.global().async {
            self.nickname = "카스타드"
        }
        print(">>>>", nickname)
        
    }
    
    func mutex() {
        
        print(">>", nickname)
        DispatchQueue.global().async {
            self.nicknameLock.lock()
            self.nickname = "칙촉"
            self.nicknameLock.unlock()
        }
        
        DispatchQueue.global().async {
            self.nicknameLock.lock()
            self.nickname = "카스타드"
            self.nicknameLock.unlock()
        }
        print(">>>>", nickname)
        
    }
    
    func semaphore() {
        
        print(">>", nickname)
        DispatchQueue.global().async {
            self.nicknameSemaphore.wait()
            self.nickname = "칙촉"
            self.nicknameSemaphore.signal()
        }
        
        DispatchQueue.global().async {
            self.nickname = "카스타드"
        }
        print(">>>>", nickname)
        
    }
}

