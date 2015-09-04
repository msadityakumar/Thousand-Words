//
//  TWCoreDataHelper.m
//  Thousand Words
//
//  Created by Aditya kumar on 04/09/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWCoreDataHelper.h"


@implementation TWCoreDataHelper

+(NSManagedObjectContext*)managedDataContext
{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    return context;
}

@end
