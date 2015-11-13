//
//  ProductClass.h
//  E-Shop
//
//  Created by Sagar Daundkar on 12/11/2015.
//  Copyright © 2015 Sagar Daundkar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductClass : NSObject


@property (nonatomic ,strong) NSString *imageUrl;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSString *addToCartUrl;
@property (nonatomic ,strong) NSString *manufacture;
@property (nonatomic ,strong) NSString *artistName;
@property (nonatomic ,strong) NSString *productId;
@property (nonatomic ,strong) NSString *_class;
@property (nonatomic) double salePrice;
@property (nonatomic) double sku;
@property (nonatomic) int rank;
@end
