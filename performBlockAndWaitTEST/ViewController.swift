//
//  ViewController.swift
//  performBlockAndWaitTEST
//
//  Created by GabrielMassana on 15/04/2016.
//  Copyright © 2016 GabrielMassana. All rights reserved.
//

import UIKit

import CoreOperation
import CoreDataFullStack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.performBlockAndWait { () -> Void in
        }
        
        addOperations()
    }
    
    func addOperations() {
        
        for (var index: Int = 0; index < 100; index++) {
            
            let operation: TestOperation = TestOperation(index: index)
            operation.operationQueueIdentifier = LocalDataOperationQueueTypeIdentifier
            
            operation.onSuccess = { (result:AnyObject?) -> Void in
                
                print("success operation: " + String(index))
            }
            
            COMOperationQueueManager.sharedInstance().addOperation(operation)
        }
    }
}

