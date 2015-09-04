//
//  TWPictureDataTransformer.m
//  Thousand Words
//
//  Created by Aditya kumar on 04/09/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWPictureDataTransformer.h"

@implementation TWPictureDataTransformer

+(Class)transformedValueClass
{

    return [NSData class];
}

+(BOOL)allowsReverseTransformation
{
    return YES;
}

-(id)transformedValue:(id)value
{
    //converting from image to data
    return UIImagePNGRepresentation(value);

}

-(id)reverseTransformedValue:(id)value
{
    //converting from data to image
    UIImage *img = [UIImage imageWithData:value];
    
    return img;
}

@end
