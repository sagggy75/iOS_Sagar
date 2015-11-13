//
//  ProductDetailsViewController.m
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "ProductClass.h"
#import "ReviewProductViewController.h"
@interface ProductDetailsViewController ()

@end

@implementation ProductDetailsViewController
@synthesize productDetails,productClass,productName;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.productName.text=self.productDetails.name;
    self.productClass.text=self.productDetails._class;
    
    //self.imageView.image=self.productDetails.imageUrl;
    NSLog(@"%@",self.productDetails.imageUrl);
    self.salePrice.text=[NSString stringWithFormat:@"%f",self.productDetails.salePrice];
    NSLog(@"%f",productDetails.sku);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"productReview"])
    {
        ReviewProductViewController *vc=segue.destinationViewController;
        vc.productSku=self.productDetails.sku;
        
    }
    
}



- (IBAction)reviewProduct:(id)sender {
    
}
@end
