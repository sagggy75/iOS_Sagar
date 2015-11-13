//
//  productViewController.h
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface productViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>



@property NSString *categoryIdForProduct;
@property NSMutableArray *productArray;
- (IBAction)subCategoryButton:(id)sender;

- (IBAction)tredingProducts:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *producttableView;

@end
