//
//  TWCollectionPhotoViewCell.m
//  Thousand Words
//
//  Created by abhishek on 24/08/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWCollectionPhotoViewCell.h"
#define  IMGVIEW_FRAME_WIDTH 5

@implementation TWCollectionPhotoViewCell



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self =   [super initWithCoder:aDecoder];
    [self setup];
    
    return self;
}

-(void)setup
{
    NSLog(@"width:%f  ,height : %f",self.bounds.size.width,self.bounds.size.height);
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectInset(CGRectMake(0, 0, 150, 150),IMGVIEW_FRAME_WIDTH , IMGVIEW_FRAME_WIDTH)];
    [self.contentView addSubview:self.imageView];
}
@end
