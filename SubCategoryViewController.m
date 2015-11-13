//
//  SubCategoryViewController.m
//  E-Shop
//
//  Created by Sagar Daundkar on 13/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import "SubCategoryViewController.h"
#import "ProductClass.h"
@interface SubCategoryViewController ()

@end

@implementation SubCategoryViewController
@synthesize categoryId;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    subCategoryArray=[[NSMutableArray alloc]init];
    subCategoryArray=[[NSMutableArray alloc]init];
    NSLog(@"%@",categoryId);
    
    //http://api.bestbuy.com/v1/categories(id="+categoryId+")?format=json&apiKey=rw5mk6btukthdwu45xbwcssx&show=subCategories
    
    NSString *str=[NSString stringWithFormat:@"http://api.bestbuy.com/v1/categories(id=%@)?format=json&apiKey=rw5mk6btukthdwu45xbwcssx&show=subCategories",categoryId];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         
         if (error)
         {
             NSLog(@"Error");
         }
         else
         {
             [subCategoryArray removeAllObjects];
             NSError *e;
             NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
             
             NSMutableArray *tempArray = [response objectForKey:@"categories"];
             NSLog(@"%@",tempArray);
             
             //NSMutableDictionary *array=[tempArray objectAtIndex:@"subcategories"];
            for(NSMutableDictionary *dict in tempArray)
            {
                ProductClass *product=[[ProductClass alloc]init];
                NSMutableArray *mdict=[dict objectForKey:@"subCategories"];
                product.productId=[mdict valueForKey:@"id"];
               // product.productId=[dict valueForKey:@"id"];
                product.name=[mdict valueForKey:@"name"];
                [subCategoryArray addObject:product];
            }
             [self.subCategoryTableView reloadData];
         }
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    ProductClass *product=[subCategoryArray objectAtIndex:indexPath.row];
    cell.textLabel.text=product.name;
    return  cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subCategoryArray count];
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
