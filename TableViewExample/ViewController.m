//
//  ViewController.m
//  TableViewExample
//
//  Created by Rajesh PR on 23/05/13.
//  Copyright (c) 2013 GTL. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tblView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.tblView.delegate = self;
    self.navigationItem.rightBarButtonItem =self.editButtonItem;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"exercise" ofType:@"plist"];
    exercises = [NSMutableArray arrayWithContentsOfFile:filePath];
    NSLog(@"%@", exercises);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate{
    [super setEditing:editing animated:animate];
    
    [self.tblView setEditing:editing animated:YES];
}

#pragma mark - TableView dataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0) return 6;
    if(section == 1) return 12;
    if(section == 2) return (exercises.count - 18);
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                                 initWithStyle:UITableViewCellStyleSubtitle
                                 reuseIdentifier:@"cell"];
    }

    //indexPath.row
    int row = indexPath.row;
    if(indexPath.section == 1) row = row+6;
    if(indexPath.section == 2) row = row+18;
    cell.textLabel.text = [exercises objectAtIndex:row];
    cell.detailTextLabel.text = @"Subtitle goes here";
    cell.imageView.image = [UIImage imageNamed:@"cellimage.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0) return @"Section 0";
    if(section == 1) return @"Section 1";
    if(section == 2) return @"Section 2";
    return @"Section";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//Handle deletion
-(void)tableView:(UITableView *)tableView
    commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
    forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"add");
    }
    else if (editingStyle == UITableViewCellEditingStyleDelete){
        int row = indexPath.row;
        if(indexPath.section == 1) row = row+6;
        if(indexPath.section == 2) row = row+18;
        [exercises removeObjectAtIndex:row];
        [tableView reloadData];
    }
}

// Handle reorder
- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
    toIndexPath:(NSIndexPath *)toIndexPath{
    NSString *old = [exercises objectAtIndex:fromIndexPath.row];
    [exercises removeObjectAtIndex:fromIndexPath.row];
    [exercises insertObject:old atIndex:toIndexPath.row];
    NSLog(@"%@", exercises);
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView
          editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

#pragma mark - TableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d", indexPath.row);
    SecondViewController *sv = [[SecondViewController alloc]
                                initWithNibName:@"SecondViewController"
                                bundle:nil];
    sv.str = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self.navigationController pushViewController:sv animated:YES];
    
}

- (void)viewDidUnload {
    [self setTblView:nil];
    [super viewDidUnload];
}
@end
