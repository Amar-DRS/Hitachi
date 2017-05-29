//
//  MyProtocals.h
//
//
//  Created by AmarDRS on 11/17/14.
//  Copyright (c) 2016. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WebServiceResponseProtocal <NSObject>

@optional
-(void)webApiResponseData:(NSData *)responseDictionary apiName:(NSString *)apiName;
-(void)webApiResponseError:(NSError *)errorDictionary;
@end



@interface MyProtocals : NSObject

@end
