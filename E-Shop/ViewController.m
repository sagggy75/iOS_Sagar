//
//  ViewController.m
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import "ViewController.h"
#import "productViewController.h"
#import "CategoryClass.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize categoryArray,categoryID,searchCategories;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    categoryArray=[[NSMutableArray alloc]init];
    categoryID=[[NSString alloc]init];
    
    

    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSString *str=@"http://api.bestbuy.com/v1/categories?format=json&apiKey=ceypj2wdrz7bshb2axw7brfk";
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
             [categoryArray removeAllObjects];
             NSError *e;
             NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
             
             NSArray *tempArray = [response objectForKey:@"categories"];
             if ([tempArray isKindOfClass:[NSArray class]])
             {
                 NSMutableArray *array = [response objectForKey:@"categories"];
                 
                 for(NSMutableDictionary *dict in array)
                 {
                     CategoryClass *cat=[[CategoryClass alloc]init];
                     cat.categoryId=[dict valueForKey:@"id"];
                     cat.categoryName=[dict valueForKey:@"name"];
                     NSLog(@"%@",cat.categoryName);
                     [categoryArray addObject:cat];
                 }
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.tableviewCategories reloadData];
                 });
                 
                 NSLog(@"data from Url:%@",categoryArray);
                 
             }
         }
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableViewMethods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[[UITableViewCell alloc]init];
     CategoryClass *class=[categoryArray objectAtIndex:indexPath.row];
    cell.textLabel.text=class.categoryName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [categoryArray count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableviewCategories deselectRowAtIndexPath:indexPath animated:YES];
    
    CategoryClass *cat = [categoryArray objectAtIndex:indexPath.row];
    productViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]
                                 instantiateViewControllerWithIdentifier:@"product_Storyboard"];
    vc.categoryIdForProduct = cat.categoryId;
    [self.navigationController pushViewController:vc animated:YES];

}



#pragma Buttons
- (IBAction)searchBarButton:(id)sender {
    if(searchCategories){
    
    NSString *str1=[NSString stringWithFormat:@"http://api.bestbuy.com/v1/categories(name=%@)?format=json&apiKey=ceypj2wdrz7bshb2axw7brfk",searchCategories.text];
    
    
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
             [categoryArray removeAllObjects];
             
             NSError *e;
             NSMutableDictionary *response1=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&e];
             NSArray *temparray=[response1 objectForKey:@"categories"];
             if([temparray isKindOfClass:[NSArray class]])
             {
                 NSMutableArray *array=[response1 objectForKey:@"categories"];
                for(NSMutableDictionary *dict in array)
                {
                    CategoryClass *class=[[CategoryClass alloc]init];
                    class.categoryName=[dict valueForKey:@"id"];
                    class.categoryName=[dict valueForKey:@"name"];
                    [categoryArray addObject:class];
                }
                 NSLog(@"data from Url:%@",categoryArray);
                 [self.tableviewCategories reloadData];
                 
             }
             
         }
         
     }];
    }
    else{
        NSLog(@"nil");
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
@end
