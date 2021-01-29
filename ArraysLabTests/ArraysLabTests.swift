//
//  ArraysLabTests.swift
//  ArraysLabTests
//
//  Created by Kevin McQuown on 1/29/21.
//

import XCTest
import Combine

class ArraysLabTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThreeLargest() throws {
        let result = Lab().largestThree(input: [3,6,1,2,9,14,8])
        XCTAssertTrue(result.contains(14) && result.contains(9) && result.contains(9))
    }
    
    func testThreeLargest2() throws {
        let result = Lab().largestThree(input: [15,25])
        XCTAssertTrue(result.contains(15) && result.contains(25) && result.count == 2)
    }
    
    func testThreeLargest3() throws {
        let result = Lab().largestThree(input: [])
        XCTAssertTrue(result.count == 0)
    }
    
    func testOddNumbers() throws {
        XCTAssertEqual(Lab().oddNumber(input: [2,8,3, 1, 7, 33, 13, 9, 22, 56]), [1, 3, 7, 9, 13, 33])
    }
    
    func testIsPrime() throws {
        XCTAssertTrue(Lab().isPrime(input: 13))
    }
    
    func testIsPrime2() throws {
        XCTAssertFalse(Lab().isPrime(input: 22))
    }
    
    func testIsPrime3() throws {
        XCTAssertFalse(Lab().isPrime(input: 0))
    }
    
    func testIsPrime4() throws {
        XCTAssertTrue(Lab().isPrime(input: 1))
    }
    
    func testIsPrime5() throws {
        XCTAssertFalse(Lab().isPrime(input: 2))
    }
    
    func testIsPrime6() throws {
        XCTAssertTrue(Lab().isPrime(input: 3))
    }
    
    func testFirstTwentyPrime() throws {
        XCTAssertEqual([71, 67, 61, 59, 53, 47, 43, 41, 37, 31, 29, 23, 19, 17, 13, 11, 7, 5, 3, 1], Lab().first20PrimeNumbers())
    }
    
    func testSwap() throws {
        var a = 8
        var b = 4
        Lab().swap(a: &a, b: &b)
        XCTAssertTrue(a == 4 && b == 8)
    }
    
    func testRandomNumbersFail() throws {
        XCTAssertNil(Lab().randomNumbers(numberOfRandoms: 10, lowerBound: 0, upperBound: 8))
    }

    func testRandomNumbersFail2() throws {
        XCTAssertNil(Lab().randomNumbers(numberOfRandoms: 10, lowerBound: 10, upperBound: 5))
    }

    func testRandomNumbersSuccess() throws {
        let expectation = XCTestExpectation(description: "check for duplicates")
        var request = URLRequest(url: URL(string: "http://localhost:3000/hasDuplicatesAtIndex")!)
        //var request = URLRequest(url: URL(string: "http://google.com")!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let jsonData = try? JSONSerialization.data(withJSONObject: Lab().randomNumbers(numberOfRandoms: 10, lowerBound: 0, upperBound: 50))
        request.httpBody = jsonData
        var cancellable: Cancellable
        cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        print("Bad response from server")
                        throw URLError(.badServerResponse)
                    }
                return element.data
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    print ("Received completion: \(completion).")
                switch completion {
                case .finished:
                    XCTAssertTrue(true)
                    expectation.fulfill()
                case .failure(_):
                    XCTFail()
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                expectation.fulfill()
            })
        wait(for: [expectation], timeout: 2.0)
    }
}
