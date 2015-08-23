//
//  TWTableViewController.h
//  Thousand Words
//
//  Created by abhishek on 22/08/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWTableViewController : UITableViewController


@property(strong,nonatomic) NSMutableArray* albumsArray;
- (IBAction)addButtAction:(id)sender;

@end
