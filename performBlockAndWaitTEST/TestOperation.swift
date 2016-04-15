//
//  TestOperation.swift
//  performBlockAndWaitTEST
//
//  Created by GabrielMassana on 15/04/2016.
//  Copyright © 2016 GabrielMassana. All rights reserved.
//

import UIKit

import CoreOperation
import CoreDataFullStack


class TestOperation: COMOperation {

    //MARK: - Accessors

    var index: Int?

    let trendingHashtags: NSArray = [
        [
            "id" : "613",
            "name" : "a",
        ],
        [
            "id" : "645",
            "name" : "sushma",
        ],
        [
            "id" : "530",
            "name" : "gregcats",
        ],
        [
            "id" : "5301",
            "name" : "gregcats1",
        ],
        [
            "id" : "5302",
            "name" : "gregcats2",
        ],
        [
            "id" : "5303",
            "name" : "gregcats3",
        ],
    ];
    
    //MARK: - Init
    
    init(index: Int) {
        
        super.init()
        
        self.index = index
        
        identifier = String("TestOperation - " + String(index))
    }
    
    //MARK: - Start
    
    override func start() {
        
        super.start()
        
        if ((self.index! % 2) == 0) {
            
            sleep(1)
        }

        CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext.performBlockAndWait { () -> Void in
            
            print("\(self.index) - Start")
            
            if ((self.index! % 2) != 0) {
                
                sleep(1)
            }
            
            do {
                
                try self.throwsExceptionAlways()
            }
            catch
            {
                print("\(self.index) - Throws")
            }
            
            for trendingHashtag in self.trendingHashtags {
                
                let newTrendingHashtag = CDFInsertService.insertNewObjectForEntityClass(TrendingHashtag.self, inManagedObjectContext: CDFCoreDataManager.sharedInstance().backgroundManagedObjectContext) as? TrendingHashtag
                
                newTrendingHashtag?.name = trendingHashtag["name"] as? String
                newTrendingHashtag?.trendingHashtagID = trendingHashtag["id"] as? String
            }
            
            print("\(self.index) - End")
        }
    }
    
    //MARK: - Cancel
    
    override func cancel() {
        
        super.cancel()
        
        didSucceedWithResult(nil)
    }
    
    func throwsExceptionAlways() throws {
        
        if ((self.index! % 3) == 0) {
            
            throw NSError.init(domain: "", code: 1, userInfo: nil)
        }
    }
}
