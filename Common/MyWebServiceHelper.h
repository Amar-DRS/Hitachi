//
//  MyWebServiceHelper.h
//  
//
//  Created by AmarDRS on 11/17/16.
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyProtocals.h"
#import "MyCustomClass.h"
#import "define.h"



@interface MyWebServiceHelper : NSObject
{
    NSString *apiName;
}
@property (nonatomic,strong) id <WebServiceResponseProtocal> webApiDelegate;
-(void)DashboardList:(NSDictionary *)InputValue;
-(void)loginApi:(NSDictionary *)loginData;
-(void)ProductSearchDD:(NSDictionary *)SearchParameter;
-(void)ProductSearch:(NSDictionary *)SearchParameter;
-(void)BroucherList:(NSDictionary *)InputValue;
-(void)FeaturedVideoList:(NSDictionary *)InputValue;
-(void)ProductVideoList:(NSDictionary *)InputValue;
-(void)TVCVideoList:(NSDictionary *)InputValue;

-(void)ProductDetail:(NSDictionary *)InputValue;
-(void)OfferList:(NSDictionary *)InputValue;
-(void)POPList:(NSDictionary *)InputValue;
















@end
