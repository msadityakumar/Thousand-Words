//
//  TWFilterCollectionViewController.m
//  Thousand Words
//
//  Created by abhishek on 08/09/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWFilterCollectionViewController.h"
#import "TWCollectionPhotoViewCell.h"
#import "Photo.h"


@interface TWFilterCollectionViewController ()


@property (strong,nonatomic)NSMutableArray *filters;
@property (strong,nonatomic)CIContext *context;

@end

@implementation TWFilterCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _filters = [[[self class]getFilters] mutableCopy];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
-(NSMutableArray *)filters
{
    if(!_filters) _filters =  [[NSMutableArray alloc]init];
    
    return _filters;

}

-(CIContext*)context
{
    if (!_context) _context = [CIContext contextWithOptions:nil];
        
    return _context;
}

+(NSArray*)getFilters
{
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:nil];
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:nil];
    
    CIFilter *instant = [CIFilter filterWithName:@"CIPhotoEffectInstant" keysAndValues: nil];
    
    CIFilter *transfer = [CIFilter filterWithName:@"CIPhotoEffectTransfer" keysAndValues:nil];
    
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls" keysAndValues:kCIInputSaturationKey,@0.5, nil];
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignetteEffect" keysAndValues:nil];
    
    CIFilter *noir = [CIFilter filterWithName:@"CIPhotoEffectNoir" keysAndValues:nil];
    
    CIFilter *colorClamp = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputMaxComponents",[CIVector vectorWithX:0.9 Y:0.9 Z:0.9 W:0.9],@"inputMinComponents",[CIVector vectorWithX:0.2 Y:0.2 Z:0.2 W:0.2], nil];
    
    CIFilter *unsharpen = [CIFilter filterWithName:@"CIUnsharpMask" keysAndValues: nil];
    
    CIFilter *monoChrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:nil];
    
    NSArray *allFilters = @[sepia,blur,instant,transfer,colorControls,vignette,noir,colorClamp,unsharpen,monoChrome];

    return allFilters;
    
}


-(UIImage *)filteredImageFromImage:(UIImage*)image WithFilter:(CIFilter*)filter
{
//getting ciimage from uiimage
    CIImage *unfilteredImg = [[CIImage alloc]initWithCGImage:image.CGImage];
    //applying filter
    [filter setValue:unfilteredImg forKey:kCIInputImageKey];
    //get the output image
    CIImage *filteredImg = [filter outputImage];
    CGRect extent = [filteredImg extent];
    // creating the cgimage
    CGImageRef cgImage = [self.context createCGImage:filteredImg fromRect:extent];
//getting final image from cgimage
    UIImage *finalImg =[UIImage imageWithCGImage:cgImage];
    return finalImg;
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return [_filters count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *indetifier = @"identifier";
    
    TWCollectionPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indetifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell setBackgroundColor:[UIColor whiteColor]];
   // cell.imageView.image = self.photo.image;
    cell.imageView.image = [self filteredImageFromImage:self.photo.image WithFilter:_filters[indexPath.row]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWCollectionPhotoViewCell *cell = (TWCollectionPhotoViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    self.photo.image = cell.imageView.image;
    
    NSError *error = nil;
    
    if (![[self.photo managedObjectContext] save:&error]) {
        NSLog(@"%@",error);
    }
    
    [self.navigationController popViewControllerAnimated:YES];


}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
