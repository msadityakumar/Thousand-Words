//
//  TWCollectionViewController.m
//  Thousand Words
//
//  Created by abhishek on 23/08/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWCollectionViewController.h"
#import "TWCollectionPhotoViewCell.h"
#import "Photo.h"
#import "TWPictureDataTransformer.h"
#import "TWCoreDataHelper.h"
#import "TWPhotoViewController.h"


@interface TWCollectionViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) NSMutableArray *photos;
@end

@implementation TWCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    NSSet *unorderedPhotos = self.albumName.photos;
    NSSortDescriptor *date = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    NSArray *sortedPics = [unorderedPhotos sortedArrayUsingDescriptors:@[date]];
    self.photos = [sortedPics mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray *)photos
{

    if (!_photos) {
        _photos = [[NSMutableArray alloc]init];
    }
    return _photos;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cameraButtonAction:(UIBarButtonItem *)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    [picker setDelegate:self];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - UIIMAGE_PICKER_DELEGATES

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    [self.photos addObject:[self photoFromImage:image]];
    [self.collectionView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"\ncancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
    

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[TWPhotoViewController class]]) {
            TWPhotoViewController *target = segue.destinationViewController;
            
            NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
            Photo *selectedPhoto = [self.photos objectAtIndex:indexPath.row];
            target.photo = selectedPhoto;
        }
    }
    
}


-(Photo *)photoFromImage:(UIImage*)image
{
    Photo *photo = [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:[TWCoreDataHelper managedDataContext]];
    photo.image = image;
    photo.date = [NSDate date];
    photo.albumBook = self.albumName;
    
    NSError *error = nil;
    if (![[photo managedObjectContext] save:&error]) {
        NSLog(@"\n%@",error);
    }
    return photo;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [_photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"Cell Photo";
    TWCollectionPhotoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell
    Photo *photo = [_photos objectAtIndex:indexPath.row];
    [cell setBackgroundColor:[UIColor redColor]];
    cell.imageView.image = photo.image;
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
