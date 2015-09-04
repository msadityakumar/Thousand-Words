//
//  TWTableViewController.m
//  Thousand Words
//
//  Created by abhishek on 22/08/15.
//  Copyright (c) 2015 abhishek. All rights reserved.
//

#import "TWTableViewController.h"
#import "Album.h"
#import "TWCollectionViewController.h"

@interface TWTableViewController ()<UIAlertViewDelegate>

@end

@implementation TWTableViewController


-(NSMutableArray *)albumsArray
{
    if (!_albumsArray)  _albumsArray = [[NSMutableArray alloc]init];
    return _albumsArray;

}

- (IBAction)addButtAction:(id)sender {

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter the album name" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Album"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    id delegate =[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSError *error = nil;
    NSArray *fetchedAlbums = [context executeFetchRequest:fetchRequest error:&error];
    self.albumsArray = [fetchedAlbums mutableCopy];
    [self.tableView reloadData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [_albumsArray count];
}

-(Album*)albumWithName:(NSString*)name
{
    id delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    
    Album *album = [NSEntityDescription insertNewObjectForEntityForName:@"Album" inManagedObjectContext:context];
    album.name = name;
    album.date = [NSDate date];
    
    NSError *error= nil;
    if([context save:&error])
    {
    //error
    }
    return album;
}

#pragma mark - AlertView_Delegates

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //add the alblum
        NSString *albumName =   [alertView textFieldAtIndex:0].text;
        [self.albumsArray addObject: [self albumWithName:albumName]];
        NSIndexPath *indexPath = [NSIndexPath  indexPathForRow:[self.albumsArray count]-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Album *album = [self.albumsArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:album.name];
    
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"albumChoosen"]) {
        
        
        if ([segue.destinationViewController isKindOfClass:[TWCollectionViewController class]]) {
            NSIndexPath *path = [self.tableView indexPathForSelectedRow];
            TWCollectionViewController *target = segue.destinationViewController;
            target.albumName = [self.albumsArray objectAtIndex:path.row];
        }
        
    }
}


@end
