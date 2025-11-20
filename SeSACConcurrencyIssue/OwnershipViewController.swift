//
//  OwnershipViewController.swift
//  SeSACConcurrencyIssue
//
//  Created by andev on 11/20/25.
//

import UIKit

/// Swift 2.3
/// Swift 3
/// Swift 4+ Codable
/// Swift 5 ABI
/// Swift 5.1 (SwiftUI)
///  - Opaque Type / Property Wrapper
/// Swift 5.5 (Concurrency)
///  - Async/Await, actor, sendable
/// Swift 5.9
///  - noncopyable / ownership
/// Swift 6
///  - 컴파일 타임에 동시성 이슈 해결
///  - @preconcurrency
///  - nonisolated

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

struct Person: ~Copyable {
    let name: String
    let age: Int
    
    func test() {
        print(#function)
    }
    
    consuming func test2() {
        print(#function)
    }
    
    deinit {
        print("Person Deinit")
    }
}

class OwnershipViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchUser()
        fetchPerson()
        print("viewDidLoad End")
        
    }
    
    func fetchMovePerson() {
        let person = Person(name: "jack", age: 11)
        print(person.name)
        
        let newPerson = consume person // 소유권 이동
        print(newPerson.name)
        
        introduce(test: newPerson) // 소유권을 넘겨보자 -> 소유권에 대한 이동 없이 참조만, 읽기만
        
        print(newPerson.name) // 매개변수 test로 소유권이 넘어가버려 newPerson 사용 불가
    }
    
    func introduce(test: borrowing Person) {
        print("이름은 \(test.name)이고 나이는 \(test.age)세 입니다.")
    }
    
    func fetchPerson() {
        let person = Person(name: "Jack", age: 11)
        print(person.name)
        print(person.test2())
        print(#function, person.name)
    }
    
    func fetchUser() {
        
        var nickname = "고래밥" //nickname 변수가 newName에 할당이 안되게 하자
        var newName = nickname
        var jackname = nickname
        newName = "123"
        
        let user = User2(name: "Jack", age: 22)
        print(user.name)
        
        let newUser = consume user // 소유권 이동
        print(newUser.name)
        //print(user.name)
    }

}
