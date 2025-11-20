//
//  OwnershipViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by andev on 11/20/25.
//

import UIKit

/// Copyable: Swift 5.9+ 값 타입의 복사를 정의
/// 값 타입에는 Copyable Protocol이 이미 정의되어 있음

// -> 값 타입을 복사할 필요가 없다면? noncopyable type == Move only type
// - 컴파일 시점에 복사를 방지하도록 보장
// - 복사로 인한 의도하지 않은 중복, 성능 최적화, 데이터 무결성 등을 보장
// -> consume consuming borrowing

struct User2: ~Copyable {
    let name: String
    let age: Int
    
    deinit {
        print("User2 \(name) Deinit")
    }
}

class OwnershipViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        print("viewDidLoad End")

        
    }
    
    func fetchUser() {
        
        var nickname = "고래밥" //nickname 변수가 newName에 할당이 안되게 하자
        var newName = nickname
        var jackname = nickname
        newName = "123"
        
        
        let user = User2(name: "Jack", age: 22)
        print(user.name)
        
        let newUser = user
        print(newUser.name)
        //print(user.name)
    }

}
