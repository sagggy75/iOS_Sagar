//
//  TredingProductViewController.m
//  E-Shop
//
//  Created by Sagar Daundkar on 13/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import "TredingProductViewController.h"
#import "ProductClass.h"
#import "ProductTableViewCell.h"
#import "ProductDetailsViewController.h"
@interface TredingProductViewController ()

@end

@implementation TredingProductViewController
@synthesize tredingCatId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",tredingCatId);
    productArray=[[NSMutableArray alloc]init];
     //http://api.bestbuy.com/beta/products/trendingViewed(categoryId="+categoryId+")?apiKey=rw5mk6btukthdwu45xbwcssx
    
    NSString *str1=[NSString stringWithFormat:@"http://api.bestbuy.com/beta/products/trendingViewed(categoryId=%@)?apiKey=rw5mk6btukthdwu45xbwcssx",tredingCatId];
    NSString *newstr=[str1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url=[NSURL URLWithString:newstr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         //parse JSON data
         if(error)
         {
             
             
         }
         else{
             [productArray removeAllObjects];
             
             NSError *e;
             NSDictionary *response=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
             NSLog(@"%@",response);
             NSArray *temparray=[response objectForKey:@"results"];
             if([temparray isKindOfClass:[NSArray class]])
             {
               NSMutableArray *Array =[response objectForKey:@"results"];
                 for(NSMutableDictionary *dict in Array)
                 {
                     ProductClass *product=[[ProductClass alloc]init];
                     NSMutableDictionary *mdict=[dict objectForKey:@"names"];
                     product.name=[mdict valueForKey:@"title"];
                     NSMutableDictionary *rdict=[dict objectForKey:@"prices"];
                     product.salePrice=[[rdict valueForKey:@"current"]doubleValue];
                     //product.rank=[[dict valueForKey:@"rank"]int];
                     [productArray addObject:product];
                 }
                 
             }
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.tredingTableView reloadData];
             });
             NSLog(@"data from url:%@",productArray);

         }
     }];
    
    [self.tredingTableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"productCell"];
    self.tredingTableView.rowHeight=122;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell= [[UITableViewCell alloc]init];
    ProductTableViewCell *cell=[self.tredingTableView dequeueReusableCellWithIdentifier:@"productCell"];
    ProductClass *product=[productArray objectAtIndex:indexPath.row];
    
    cell.productName.text=product.name;
    cell.productSalePrice.text=[NSString stringWithFormat:@"%f",product.salePrice];
    cell.imageView.image=[UIImage imageNamed:@"three_leaf_clover.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [productArray count];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tredingTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductClass *product = [productArray objectAtIndex:indexPath.row];
    ProductDetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
                                        instantiateViewControllerWithIdentifier:@"product_details"];
    vc.productDetails = product;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
