//
//  TWPhotoViewController.m
//  Thousand Words
//
//  Created by Aditya kumar on 04/09/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWPhotoViewController.h"
#import "Photo.h"

@interface TWPhotoViewController ()

@end

@implementation TWPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.imageView.image = self.photo.image;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addFilterButtAction:(id)sender {
}

- (IBAction)deleteButtAction:(id)sender {
    
    [[self.photo managedObjectContext] deleteObject:self.photo];
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
