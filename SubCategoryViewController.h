//
//  SubCategoryViewController.h
//  E-Shop
//
//  Created by Sagar Daundkar on 13/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCategoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *subCategoryArray;
}
@property NSString *categoryId;
@property (weak, nonatomic) IBOutlet UITableView *subCategoryTableView;

@end
