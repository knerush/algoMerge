//
//  ViewController.swift
//  Algo1
//
//  Created by Katya Nerush on 29/10/2015.
//  Copyright © 2015 KN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let inputNumbers = arrayFromContentsOfFileWithName("IntegerArray")
        let inputNumbers = arrayFromContentsOfFileWithName("IntegerArray")
        
        let numericData = translateToNumbers(inputNumbers!)
        let invariationsNum = inversionsCountMergeSortForArray(numericData)
//        let invariationsNumCheck = invariationsCountForArray(numericData)

        print("inv: \(invariationsNum)")
//        print("inv2: \(invariationsNumCheck)")
    }

    func translateToNumbers(strings:[String]) -> [Int] {
        var res = [Int]()
        
        for var s in strings {
            s = s.stringByTrimmingCharactersInSet(NSCharacterSet.init(charactersInString: "\r\n "))
            if s == "" {
                continue
            }

            res.append( Int(s)! )

        }
        
        return res;
    }
    
    
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            return content.componentsSeparatedByString("\n")
            
        } catch _ as NSError {
            return nil
        }
    }
    
    
    //MARK :- merge sort here
    
    func inversionsCountMergeSortForArray(numbers:[Int]) -> Int {
        let invCount = 0
        let res = mergeSort(numbers, currentInvNumber: invCount)
//        print("Sorted array \(res.0)")
        return res.1
        
    }
    
    func mergeSort(input:[Int], currentInvNumber:Int) -> ([Int], Int) {
        if input.count == 1 {
            let num:Int = Int(input[0])
            return ([num], 0)
        }
        
        let middleIndex:Int = input.count/2
        let A = mergeSort(Array(input[0..<middleIndex]), currentInvNumber: currentInvNumber)
        let B = mergeSort(Array(input[middleIndex..<input.count]), currentInvNumber: currentInvNumber)
    
        return merge(A.0, B: B.0, invNum:A.1+B.1)

    }
    
    //return tuple with inversion number
    func merge(A:[Int], B:[Int], var invNum : Int) -> ([Int], Int) {
        var res = [Int]()
    
//        let m = max(A.count, B.count) - 1
        let k = A.count + B.count - 1
        
        var i:Int = 0
        var j:Int = 0;
        for _ in 0...k{

            if (A[i] <= B[j]) {
                res.append(A[i])
                i++
            }
            else {
                res.append(B[j])
                invNum = invNum +  (A.count - i)
                j++
            }
            
            if i > A.count - 1 {
                res.appendContentsOf(Array(B[j..<B.count]))
                break
            }
            
            if j > B.count - 1 {
                res.appendContentsOf(Array(A[i..<A.count]))
                break
            }
        }
        
        return (res, invNum)
    }
    
    
    
    //MARK :-n^2 approach
    
    func invariationsCountForArray(numbers:[Int]) -> Int {
        let nCount = numbers.count - 1
        var invCount = 0
        
        for i in 0...nCount - 1 {
            let curNum = Int(numbers[i])
            print("iteration \(i)")
            for j in i+1...nCount {
                if curNum > Int(numbers[j]) {
                    invCount++
//                    assert(i > 0)
                }
            }
        }
        return invCount;
    }
    

}

