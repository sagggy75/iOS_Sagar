//
//  productViewController.m
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import "productViewController.h"
#import "ProductClass.h"
#import "ProductDetailsViewController.h"
#import "ProductTableViewCell.h"
#import "TredingProductViewController.h"
#import "SubCategoryViewController.h"
@interface productViewController ()

@end

@implementation productViewController
@synthesize categoryIdForProduct,productArray,producttableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    productArray=[[NSMutableArray alloc]init];
     [self.producttableView registerNib:[UINib nibWithNibName:@"ProductTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"productCell"];
    self.producttableView.rowHeight=122;

}
-(void)viewWillAppear:(BOOL)animated{
    NSString *str1=[NSString stringWithFormat:@"http://api.bestbuy.com/v1/products(categoryPath.id=%@)?format=json&apiKey=ceypj2wdrz7bshb2axw7brfk",categoryIdForProduct];
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
             NSArray *temparray=[response objectForKey:@"products"];
             if([temparray isKindOfClass:[NSArray class]])
             {
                 NSMutableArray *array =[response objectForKey:@"products"];
                 
                 for(NSMutableDictionary *dict in array)
                 {
                     ProductClass *product=[[ProductClass alloc]init];
                     product.productId=[dict valueForKey:@"productId"];
                     product.addToCartUrl=[dict valueForKey:@"addToCartUrl"];
                     product.artistName=[dict valueForKey:@"artistName"];
                     product._class=[dict valueForKey:@"class"];
                     product.imageUrl=[dict valueForKey:@"image"];
                     product.name=[dict valueForKey:@"name"];
                     product.sku=[[dict valueForKey:@"sku"]integerValue];
                     product.salePrice=[[dict valueForKey:@"salePrice"]doubleValue];
                     NSLog(@"%@,%@,%@",product.productId,product._class,product.name);
                     [productArray addObject:product];
                 }
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.producttableView reloadData];
                 });
                 NSLog(@"data from url:%@",productArray);
                 
             }
             
         }
         
     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [productArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell= [[UITableViewCell alloc]init];
    ProductTableViewCell *cell=[self.producttableView dequeueReusableCellWithIdentifier:@"productCell"];
    ProductClass *product=[productArray objectAtIndex:indexPath.row];
   
    cell.productName.text=product.name;
    cell.productSalePrice.text=[NSString stringWithFormat:@"%f",product.salePrice];
    cell.imageView.image=[UIImage imageNamed:@"three_leaf_clover.png"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.producttableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductClass *product = [productArray objectAtIndex:indexPath.row];
    ProductDetailsViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
                                 instantiateViewControllerWithIdentifier:@"product_details"];
    vc.productDetails = product;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"tredingProduct"])
     {
         TredingProductViewController *vc=segue.destinationViewController;
         vc.tredingCatId=self.categoryIdForProduct;
         
     }
    else if([segue.identifier isEqualToString:@"subcategory"])
    {
        SubCategoryViewController *vc=segue.destinationViewController;
        vc.categoryId=self.categoryIdForProduct;
    }
    
}
/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if([segue.identifier isEqualToString:@"productController"]){
 NSIndexPath *indexPath=[self.tableviewCategories indexPathForSelectedRow];
 NSLog(@"%li", (long)indexPath.row);
 ProductTableViewController *productController=segue.destinationViewController;
 productController.categoryIdForProduct=categoryID;
 }
 
 }*/

- (IBAction)subCategoryButton:(id)sender {
}

- (IBAction)tredingProducts:(id)sender {
    
   
    
    
}
@end
