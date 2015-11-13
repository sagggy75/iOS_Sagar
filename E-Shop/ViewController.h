//
//  ViewController.h
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property NSMutableArray *categoryArray;
@property NSString *categoryID;
@property (weak, nonatomic) IBOutlet UISearchBar *searchCategories;
@property (weak, nonatomic) IBOutlet UITableView *tableviewCategories;

- (IBAction)searchBarButton:(id)sender;

@end

