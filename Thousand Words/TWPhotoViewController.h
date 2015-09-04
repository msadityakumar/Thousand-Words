//
//  TWPhotoViewController.h
//  Thousand Words
//
//  Created by Aditya kumar on 04/09/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Photo;

@interface TWPhotoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) Photo *photo;
@property (strong, nonatomic) IBOutlet UIButton *addFilterButtAction;
- (IBAction)addFilterButtAction:(id)sender;
- (IBAction)deleteButtAction:(id)sender;
@end
