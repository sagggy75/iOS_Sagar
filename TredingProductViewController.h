//
//  TredingProductViewController.h
//  E-Shop
//
//  Created by Sagar Daundkar on 13/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TredingProductViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *productArray;
}
@property NSString *tredingCatId;
@property (weak, nonatomic) IBOutlet UITableView *tredingTableView;
@end
