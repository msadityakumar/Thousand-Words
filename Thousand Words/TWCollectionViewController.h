//
//  TWCollectionViewController.h
//  Thousand Words
//
//  Created by abhishek on 23/08/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWCollectionViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButtAction;
- (IBAction)cameraButtonAction:(UIBarButtonItem *)sender;

@end
