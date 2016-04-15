//
//  AppDelegate.swift
//  performBlockAndWaitTEST
//
//  Created by GabrielMassana on 15/04/2016.
//  Copyright © 2016 GabrielMassana. All rights reserved.
//

import UIKit

import CoreDataFullStack
import CoreOperation

let LocalDataOperationQueueTypeIdentifier: String = "LocalDataOperationQueueTypeIdentifier"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CDFCoreDataManagerDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        CDFCoreDataManager.sharedInstance().delegate = self

        registerOperationQueues()

        return true
    }

    func registerOperationQueues() {

        let localDataOperationQueue:NSOperationQueue = NSOperationQueue()
        localDataOperationQueue.qualityOfService = .Background
        localDataOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount
        COMOperationQueueManager.sharedInstance().registerOperationQueue(localDataOperationQueue, operationQueueIdentifier: LocalDataOperationQueueTypeIdentifier)
    }
    
    internal func coreDataModelName() -> String! {
        
        return "Model"
    }
}
