//
//  ProductDetailsViewController.h
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProductClass;
@interface ProductDetailsViewController : UIViewController
{
    
}
@property (weak, nonatomic) IBOutlet UILabel *salePrice;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *productClass;
@property (weak, nonatomic) IBOutlet UILabel *productName;
- (IBAction)reviewProduct:(id)sender;

@property ProductClass *productDetails;
@property ProductClass *sku;
@end
