//
//  ReviewProductViewController.h
//  E-Shop
//
//  Created by Sagar Daundkar on 13/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewProductViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *reviewArray;
}
@property int productSku;
@property (weak, nonatomic) IBOutlet UITableView *reviewTableView;
@end
