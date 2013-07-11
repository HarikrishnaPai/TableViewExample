//
//  ViewController.h
//  TableViewExample
//
//  Created by Rajesh PR on 23/05/13.
//  Copyright (c) 2013 GTL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *exercises;
}
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end
