//
//  MyWebServiceHelper.m
//  
//
//  Created by AmarDRS on 11/17/16.
//  Copyright (c) 2016. All rights reserved.
//

#import "MyWebServiceHelper.h"

@implementation MyWebServiceHelper
@synthesize webApiDelegate;


-(void )synchronousApiRequestByPostWithDataTypeInResponse:(NSString *)urlString postData:(NSDictionary *)dataDic
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDic
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"123" forHTTPHeaderField:@"admin"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             //[webApiDelegate webApiResponseError:error];
             [MyCustomClass SVProgressMessageDismissWithError:@"Oops Network Problem"  timeDalay:1.50];

             //[MyCustomClass SVProgressMessageDismissWithError:[NSString stringWithFormat:@"Error: %@" , error]  timeDalay:1.50];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}
-(void )synchronousApiRequestByPostWithStringTypeInResponse:(NSString *)urlString postData:(NSString *)dataString
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSString *jsonString = [[NSString alloc] initWithString:dataString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)dataString.length] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
            
             [MyCustomClass SVProgressMessageDismissWithError:@"Oops Network Problem"  timeDalay:1.50];

             // [webApiDelegate webApiResponseError:error];
            // NSLog(@"Erorr: %@",[NSString stringWithFormat:@"Error: %@" , error]);
            // [MyCustomClass SVProgressMessageDismissWithError:[NSString stringWithFormat:@"Error: %@" , error]  timeDalay:1.50];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}

-(void )synchronousApiRequestByGetWithDataTypeInResponse:(NSString *)urlString
{
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    //[request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             [MyCustomClass SVProgressMessageDismissWithError:@"Oops Network Problem"  timeDalay:1.50];

            // [webApiDelegate webApiResponseError:error];
         }
         else
         {
             [self webapiResponseResultHandling:data];
         }
     }];
}

-(NSString *)synchronousApiRequest:(NSString *)urlString
{
    NSURL *mainURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",urlString]];
    NSURLRequest *request = [NSURLRequest requestWithURL:mainURL];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    return responseString;
}

#pragma mark - Response Result Handling Method list
-(void)webapiResponseResultHandling:(NSData *)data
{
    [webApiDelegate webApiResponseData:data apiName:apiName];
}

#pragma mark - API Request Method list


-(void)DashboardList:(NSDictionary *)InputValue
{
    apiName=@"DashboardList";
    NSString *urlString=[NSString stringWithFormat:@"%@useraccess.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];

}

-(void)loginApi:(NSDictionary *)loginData
{
    apiName=@"loginApi";
    NSString *urlString=[NSString stringWithFormat:@"%@login.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:loginData];
}

-(void)ProductSearch:(NSDictionary *)SearchParameter
{
    apiName=@"ProductSearch";
    NSString *urlString=[NSString stringWithFormat:@"%@product.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:SearchParameter];
}
-(void)ProductSearchDD:(NSDictionary *)SearchParameter
{
    apiName=@"ProductSearchDD";
    NSString *urlString=[NSString stringWithFormat:@"%@search.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:SearchParameter];

}


-(void)ProductDetail:(NSDictionary *)InputValue
{
    apiName=@"ProductDetail";
    NSString *urlString=[NSString stringWithFormat:@"%@related_product.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];
}
-(void)BroucherList:(NSDictionary *)InputValue
{
    apiName=@"BroucherList";
    NSString *urlString=[NSString stringWithFormat:@"%@product_details.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];

}
-(void)FeaturedVideoList:(NSDictionary *)InputValue
{
    apiName=@"FeaturedVideoList";
    NSString *urlString=[NSString stringWithFormat:@"%@product_details.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];
    

}
-(void)ProductVideoList:(NSDictionary *)InputValue
{
    apiName=@"ProductVideoList";
    NSString *urlString=[NSString stringWithFormat:@"%@product_details.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];
}

-(void)OfferList:(NSDictionary *)InputValue
{
    apiName=@"OfferList";
    NSString *urlString=[NSString stringWithFormat:@"%@product_details.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];
}

-(void)POPList:(NSDictionary *)InputValue
{
    apiName=@"POPList";
    NSString *urlString=[NSString stringWithFormat:@"%@product_details.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];
}
-(void)TVCVideoList:(NSDictionary *)InputValue;
{
    apiName=@"TVCVideoList";
    NSString *urlString=[NSString stringWithFormat:@"%@product_details.php",BASE_URL];
    [self synchronousApiRequestByPostWithDataTypeInResponse:urlString postData:InputValue];

}
@end
