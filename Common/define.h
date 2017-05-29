//
//  define.h
//
//
//  Created by AmarDRS on 4/26/16.
//  Copyright © 2016 SupraITS. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USERDEFAULTS                [NSUserDefaults standardUserDefaults]
#define SYNCHRONISE                 [[NSUserDefaults standardUserDefaults] synchronize]
#define GETVALUE(keyname)           [[NSUserDefaults standardUserDefaults] valueForKey:keyname]
#define SETVALUE(value,keyname)     [[NSUserDefaults standardUserDefaults] setValue:value forKey:keyname]
#define DELETEVALUE(keyname)        [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyname]


#define ALBUM_NAME  @"Hitachi"
#define ALBUM_IDENTIFIER  @"albumIdentifier"
#define CSAsset_IDENTIFIER  @"assetIdentifier"
#define ALBUM_ID  @"albumid"



#define IS_IPHONE (!IS_IPAD)
#define IS_IPAD ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)

#define BASE_URL  @"http://sparrowice.devanorth.com/services/"

#define SELECTED_DD1                @"category_type"
#define SELECTED_DD2                @"product_category"
#define SELECTED_DD3                @"tonnage"
#define SELECTED_DD4                @"product_rating"

#define Download_OFFER_Failed       @"product_rating"
#define Download_POP_Failed         @"product_rating"
#define Download_Broucher_Failed    @"product_rating"

#define Download_PROBroucher_NotAVL     @"Brochure Not Available"
#define Share_PROBroucher_NotAVL        @"Brochure Not Available"
#define Download_PROBroucher_Success    @"Brochure has been downloaded successfully"
#define Download_Broucher_Success       @"Brochure has been downloaded successfully"
#define Download_POP_Success            @"POP Image has been downloaded successfully"
#define Download_OFFER_Success          @"Offer Image has been downloaded successfully"
#define DOWNLOAD_FV                     @"Download Video functionality has been disabled"

// SHARE TEXT
#define BROUCHER_SHARE_TEXT         @"Check out this product:"
#define POP_SHARE_TEXT              @"Check out this product:"
#define OFFER_SHARE_TEXT            @"Check out this product:"
#define FV_SHARE_TEXT               @"Check Out this product featured video: "
#define PRODDETAIL_SHARE_TEXT       @"Check out this product:"
#define PV_SHARE_TEXT               @"Check Out this product video:"

// get window height and width
#define Window_Height [AppDelegate SharedDelegate].window.frame.size.height
#define Window_Width  [AppDelegate SharedDelegate].window.frame.size.width

#define PASSCODE_Alert  @"Passcode Information:Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit"

#define SELECTED_USER_TYPE  @"loggedin_user_type"

#define USER_TYPE_GUEST  @3
#define USER_TYPE_SALES  @1
#define USER_TYPE_RETAILERS  @2

