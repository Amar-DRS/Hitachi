//
//  MyCustomClass.m
//
//
//  Created by AmarDRS on 11/16/14.
//  Copyright (c) 2016 All rights reserved.
//

#import "MyCustomClass.h"
NSString*patientID;

@implementation MyCustomClass

/////*******************************************************//////
/////*******************************************************//////
/////*******************************************************//////
/////*******************************************************//////

#pragma mark - Validation. Method List
//////////////////////////////////////////////////////////////////
/////////////////////1.Email Validation  by second way ///////////
//////////////////////////////////////////////////////////////////
+ (BOOL)validateEmail :(NSString*)email
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    if ([emailTest evaluateWithObject:email] == YES)
        return TRUE;
    else
        return FALSE;
}

//////////////////////////////////////////////////////////////////
/////////////////////2.Mobile number Validation        ///////////
//////////////////////////////////////////////////////////////////
+ (BOOL)validateNumber :(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

//////////////////////////////////////////////////////////////////
/////////////////////3. age validation                 ///////////
//////////////////////////////////////////////////////////////////
+ (BOOL)validateAge :(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{2}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}


#pragma mark - Date Format Method List
//////////////////////////////////////////////////////////////////
//////4. Get Current time from current Date in hour and minute////
//////////////////////////////////////////////////////////////////
+(NSString *)getCurrentTimeIn24HourFormat
{
    NSDate *currentDateForNotification = [NSDate date];
    NSDateFormatter *hourDateFormater=[[NSDateFormatter alloc] init];
    [hourDateFormater setDateFormat:@"hh:mm:ss"];
    NSString *time = [hourDateFormater stringFromDate:currentDateForNotification];
    return time;
}

//////////////////////////////////////////////////////////////////
//////5. Current time in day night formate                    ////
//////////////////////////////////////////////////////////////////
+(NSString *)getCurrentTimeIn12HourFormat
{
    NSDate* now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];;
    NSDateComponents *dateComponents = [calender components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    NSInteger hour = [dateComponents hour];
    NSString *am_OR_pm=@"AM";
    if (hour>12)
        am_OR_pm = @"AM";
    else
        am_OR_pm = @"PM";
    
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld %@", (long)hour, (long)minute, (long)second,am_OR_pm];
}


//////////////////////////////////////////////////////////////////
//////6. Get Current Day from current Date                    ////
//////////////////////////////////////////////////////////////////
+(NSString *)getCurrentDayInName
{
    NSDateFormatter *theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    NSString *weekDay =  [theDateFormatter stringFromDate:[NSDate date]];
    return weekDay;
}

//////////////////////////////////////////////////////////////////
//////7. Current day in integer of the day                    ////
//////////////////////////////////////////////////////////////////
+(NSString *)getCurrentDayInNumber:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSString *currentMonth  = [formatter stringFromDate:date];
    return currentMonth;
}

//////////////////////////////////////////////////////////////////
//////8. Current month of the day                             ////
//////////////////////////////////////////////////////////////////
+(NSString *)getCurrentMonthInName:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    NSString *currentMonth  = [formatter stringFromDate:date];
     //NSString *currentDay  = [formatter stringFromDate:date];
    return currentMonth;
   // return currentDay;
}
+(int)getWeekDaysInInteger:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:date];
    int weekday = (int)[comps weekday];
    return weekday;
}
+(int)getAgeFromDateOfBirth:(NSString *)birthday
{
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthdayDate = [dateFormat dateFromString:birthday];
    
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthdayDate
                                       toDate:now
                                       options:0];
    int age = (int) [ageComponents year];
    return age;
}

//////////////////////////////////////////////////////////////////
//////9. Current month in integer of the day                  ////
//////////////////////////////////////////////////////////////////
+(int )getCurrentMonthInNumber
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth  = [formatter stringFromDate:[NSDate date]];
    return [currentMonth intValue];
}

//////////////////////////////////////////////////////////////////
//////10. Current Week in integer of the day                  ////
//////////////////////////////////////////////////////////////////
+(int)getCurrentWeek
{
    int week;
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calender components:(NSCalendarUnitWeekOfYear) fromDate:[NSDate date]];
    NSString *data = [NSString stringWithFormat:@"%@",dateComponent];
    NSArray *component = [data componentsSeparatedByString:@"Year:"];
    NSString * weekString =[component objectAtIndex:1];
    week = [[NSString stringWithFormat:@"%@",weekString] intValue];
    return week;
}

//////////////////////////////////////////////////////////////////
//////11. Current Year in integer of the day                  ////
//////////////////////////////////////////////////////////////////
+(int)getCurrentYear:(NSDate *)date
{
    int year;
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calender components:(NSCalendarUnitYear) fromDate: date];
    NSString *data = [NSString stringWithFormat:@"%@",dateComponent];
    NSArray *component = [data componentsSeparatedByString:@"Year:"];
    NSString * weekString =[component objectAtIndex:1];
    year = [[NSString stringWithFormat:@"%@",weekString] intValue];
    return year;
}

//////////////////////////////////////////////////////////////////
//////12. Current Hour of the day                             ////
//////////////////////////////////////////////////////////////////
+(int)getCurrentHour
{
    NSDate* now = [NSDate date];
    NSCalendar *calender = [NSCalendar currentCalendar];;
    NSDateComponents *dateComponents = [calender components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:now];
    NSInteger hour = [dateComponents hour];
    NSString *am_OR_pm=@"AM";
    NSInteger minute = [dateComponents minute];
    NSInteger second = [dateComponents second];
    
    NSLog(@"Current Time  %@",[NSString stringWithFormat:@"%02ld:%02ld:%02ld %@", (long)hour, (long)minute, (long)second,am_OR_pm]);
    return (int )hour;
}

//////////////////////////////////////////////////////////////////
//////13. Current Date with all Component in Dictionary       ////
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary *)getCurrentDateWithAllComponent
{
    NSMutableDictionary *dateComponentDic =[[NSMutableDictionary alloc] init];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calender components:(NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    NSString *data = [NSString stringWithFormat:@"%@",dateComponent];
    NSArray *component = [data componentsSeparatedByString:@"\n    "];
    for (int i=1; i<component.count; i++)
    {
        NSArray *innerComponent =[[component objectAtIndex:i] componentsSeparatedByString:@":"];
        [dateComponentDic setValue:[innerComponent objectAtIndex:1] forKey:[NSString stringWithFormat:@"%@",[innerComponent objectAtIndex:0]]];
    }
    return dateComponentDic;
}

//////////////////////////////////////////////////////////////////
//////14. set Date format                                     ////
//////////////////////////////////////////////////////////////////
+(NSString *)setDateFormateWithDate : (NSDate *)yourDate dateFormate: (NSString *)dateFormate
{
    //\\ Year = yyyy  //\\ Month = MM //\\ Day  = dd //\\ Minute = mm //\\ Second = ss //\\ Hour = hh //
    
    NSString *formattedDate;
    NSDate *date = yourDate ;
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:dateFormate];
    formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

//////////////////////////////////////////////////////////////////
//////15. Any date                                            ////
//////////////////////////////////////////////////////////////////
+(NSDate *)getAnyPastOrFutureDate:(int)numberBeforeToday pastDate:(BOOL) pastDate
{
    int daysToAdd=0;
    if (pastDate)
        daysToAdd = -numberBeforeToday;
    else
         daysToAdd = numberBeforeToday;
        
    NSDate *now = [NSDate date];
    NSDateComponents *components = [[NSDateComponents alloc] init] ;
    [components setDay:daysToAdd];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDate *yesterday = [calender dateByAddingComponents:components toDate:now options:0];
    NSLog(@"Yesterday: %@", yesterday);
    return yesterday;
}

//////////////////////////////////////////////////////////////////
//////16. Time Bomb                                           ////
//////////////////////////////////////////////////////////////////
+(BOOL )myTimeBomb
{
    NSString *dateString = @"17-11-2014";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    
    //NSDate *futureDate =[MyCustomClass getAnyPastOrFutureDate:0 pastDate:NO];
    NSDate *futureDate = [dateFormatter dateFromString:dateString];
    if ([futureDate isEqualToDate:dateFromString])
    {
        return YES;
    }
    return NO;
}


#pragma mark - AlertView Method List
//////////////////////////////////////////////////////////////////
//////17. AlertView with two button only                      ////
//////////////////////////////////////////////////////////////////
+(void)alertMessageWithTwobuttonOnly :(NSString * )title message: (NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cencelButtontitle otherButtonTitle:(NSString *)otherButtonTitle
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cencelButtontitle otherButtonTitles:otherButtonTitle,nil] show];
}

//////////////////////////////////////////////////////////////////
//////18. AlertView with OONE button only                      ////
//////////////////////////////////////////////////////////////////
+(void)alertMessageWithOnebuttonOnly :(NSString * )title message: (NSString *)message delegate:(id)delegate oneButtonTitle:(NSString *)cencelButtontitle
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cencelButtontitle otherButtonTitles:nil,nil] show];
}

//////////////////////////////////////////////////////////////////
//////19. AlertView with TextField                            ////
//////////////////////////////////////////////////////////////////
+(void)alertMessageWithTextField :(NSString * )title message: (NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cencelButtontitle otherButtonTitle:(NSString *)otherButtonTitle
{
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setDelegate:delegate];
    [dialog setTitle:title];
    [dialog setMessage:message];
    [dialog addButtonWithTitle:cencelButtontitle];
    [dialog addButtonWithTitle:otherButtonTitle];
    dialog.alertViewStyle = UIAlertViewStylePlainTextInput;
    [dialog textFieldAtIndex:0].keyboardType = UIKeyboardAppearanceDefault;//UIKeyboardTypeNumberPad;
    CGAffineTransform moveUp = CGAffineTransformMakeTranslation(0.0, 0.0);
    [dialog setTransform: moveUp];
    [dialog show];
}

#pragma mark - Default Library Method List
//////////////////////////////////////////////////////////////////
/////////////////////20.Phone Call method               //////////
//////////////////////////////////////////////////////////////////
+(void) defaultPhoneCallMethod : (NSString *) phoneNumber
{
    NSURL *dialingURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:+%@",phoneNumber]];
    [[UIApplication sharedApplication] openURL:dialingURL];
}

//////////////////////////////////////////////////////////////////
/////////////////////21.Send SMS by iphone              //////////
//////////////////////////////////////////////////////////////////
+(void) defaultSmsSendByPhone : (NSString *) phoneNumber
{
    NSURL *dialingURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"telprompt:+%@",phoneNumber]];
    [[UIApplication sharedApplication] openURL:dialingURL];
}

//////////////////////////////////////////////////////////////////
/////////////////////22.Send Default email by iphone    //////////
//////////////////////////////////////////////////////////////////
+(void) defaultEmailSendByIphone : (NSString *) emailID
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",emailID]]];
}

//////////////////////////////////////////////////////////////////
/////////////////////23.Open Default map app using     address ///
//////////////////////////////////////////////////////////////////
+(void) defaultMapAppWithAddress : (NSString *) addressString
{
    addressString =  [addressString stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    NSString* urlText = [NSString stringWithFormat:@"http://maps.apple.com/?q=%@", addressString]; //http://maps.google.com/maps?q=%@
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]]; //maps.apple.com/?ll=51.84,-8.30
}

//////////////////////////////////////////////////////////////////
/////////////////////24.Open Default map app using     Lat long///
//////////////////////////////////////////////////////////////////
+(void) defaultMapAppWithLatAndLong : (float )latitude longitude:(float)longitude
{
    NSString* urlText = [NSString stringWithFormat:@"http://maps.apple.com/maps?q=%f,%f", latitude,longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}

//////////////////////////////////////////////////////////////////
///////25. Direction on map between two place ////////////////////
//////////////////////////////////////////////////////////////////
+(void) defaultSafariAppWithDirectionBetweenTwoPlace : (NSString *)sourceAddress destinationAddress:(NSString *)destinationAddress
{
    ///http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino // map app
    NSString* urlText = [NSString stringWithFormat:@"http://maps.google.com/?daddr=%@&saddr=%@", destinationAddress,sourceAddress]; // safari app
    urlText=[urlText stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}

//////////////////////////////////////////////////////////////////
///////26. Default Calendar app               ////////////////////
//////////////////////////////////////////////////////////////////
+(void)defaultCalendarApp
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"calshow://"]];
}


#pragma mark - Default File Path
//////////////////////////////////////////////////////////////////
///////27. DocumentDirectoryPath ////////////////////
//////////////////////////////////////////////////////////////////
+(NSURL *) documentsDirectoryPath
{
    NSURL *filePath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    return filePath;
}

//////////////////////////////////////////////////////////////////
///////28. Resource file path                 ////////////////////
//////////////////////////////////////////////////////////////////
+(NSString *) resourceFilePath :(NSString *)fileName fileType:(NSString *)fileType
{
    NSURL *filePath = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileType];
    if ([NSString stringWithFormat:@"%@",filePath].length>7)
    {
       return [NSString stringWithFormat:@"%@",filePath];
    }
    return @"";
}

//////////////////////////////////////////////////////////////////
///////29. Create Folder on Document Directroy  //////////////////
//////////////////////////////////////////////////////////////////
+(BOOL ) createFolderOnDocumentDirectory :(NSString *)folderName
{
    NSString *documentsDirectory = [[MyCustomClass documentsDirectoryPath] path];
    NSString *pathWithFolder = [documentsDirectory stringByAppendingPathComponent:folderName];
    NSError *error=nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathWithFolder])
        [[NSFileManager defaultManager] createDirectoryAtPath:pathWithFolder withIntermediateDirectories:YES attributes:nil error:&error];
    else
        return NO;
    
    if(error != nil)
        return NO;
    else
        return YES;
}

//////////////////////////////////////////////////////////////////
///////30. delete Folder/file on Document Directroy  //////////////////
//////////////////////////////////////////////////////////////////
+(BOOL ) deleteFileOrFolderFromDocumentDirectory :(NSString *)folderName
{
    NSString *documentsDirectory = [[MyCustomClass documentsDirectoryPath] path];
    NSString *pathWithFolder = [documentsDirectory stringByAppendingPathComponent:folderName];
    NSError *error=nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathWithFolder])
        [[NSFileManager defaultManager] removeItemAtPath:pathWithFolder error:&error];
    else
        return NO;
    
    if(error != nil)
        return NO;
    else
        return YES;
}

//////////////////////////////////////////////////////////////////
///////31. move Folder/file on Document Directroy  //////////////////
//////////////////////////////////////////////////////////////////
+(BOOL ) moveItemFromSourceToDestinationPath :(NSString *)sourcePath destinationPath:(NSString *)destinationPath
{
    //NSString *documentsDirectory = [[MyCustomClass documentsDirectoryPath] path];
    //NSString *pathWithFolder = [documentsDirectory stringByAppendingPathComponent:folderName];
    NSError *error=nil;
    [[NSFileManager defaultManager] moveItemAtPath:sourcePath toPath:destinationPath error:&error];
    
    if(error != nil)
        return NO;
    else
        return YES;
}

//////////////////////////////////////////////////////////////////
///////32. copy Folder/file on Document Directroy  //////////////////
//////////////////////////////////////////////////////////////////
+(BOOL ) copyItemfromSourceToDestinationPath :(NSString *)sourcePath destinationPath:(NSString *)destinationPath
{
    NSError *error=nil;
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
    
    if(error != nil)
        return NO;
    else
        return YES;
}

//////////////////////////////////////////////////////////////////
///////33. Create plist from nsdictionary to document folder /////
//////////////////////////////////////////////////////////////////
+(void ) createPlistOnDocumentDictionary :(NSString *)filename date:(NSMutableDictionary *)dataDic
{
    NSString *documentsDirectory = [[MyCustomClass documentsDirectoryPath] path];
    NSString *pathWithFolder = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",filename]];
    [dataDic writeToFile:pathWithFolder atomically:YES];
}

//////////////////////////////////////////////////////////////////
///////34. Create XML file from nsdictionary to document folder //
//////////////////////////////////////////////////////////////////
+(void ) createXMLFileOnDocumentDictionary :(NSString *)filename date:(NSMutableDictionary *)dataDic
{
    NSString *documentsDirectory = [[MyCustomClass documentsDirectoryPath] path];
    NSString *pathWithFolder = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml",filename]];
    [dataDic writeToFile:pathWithFolder atomically:YES];
}

//////////////////////////////////////////////////////////////////
///////35. get Data From Plist file //
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary *) getDataFromPlistFile :(NSString *)filePath
{
    NSMutableDictionary *plistDict=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    return plistDict;
}

//////////////////////////////////////////////////////////////////
///////36. get Data From XML file //
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary *) getDataFromXMLFile :(NSString *)filePath
{
    NSMutableDictionary *plistDict=[[NSMutableDictionary alloc]initWithContentsOfFile:filePath];
    return plistDict;
}


//#pragma mark - SQL Database Method List
////////////////////////////////////////////////////////////////////
/////////37. create SQliteFile //
////////////////////////////////////////////////////////////////////
//+(void)createSQLiteDateBase:(NSString *) databaseName
//{
//    NSString *documentsDirectory = [[MyCustomClass documentsDirectoryPath] path];
//    NSString *sqliteFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",databaseName]];
//    [[NSFileManager defaultManager] createFileAtPath:sqliteFilePath contents:nil attributes:nil];
//}
//
////////////////////////////////////////////////////////////////////
/////////38. create table in sqlite file                  //////////
////////////////////////////////////////////////////////////////////
//+(BOOL)createTableInSqliteFile:(NSString *) databaseName attributes :(NSMutableDictionary *)attributeDic tableName :(NSString *)tableName
//{
//    /// How to pass Attribute Dic:
//    /// NSMutableDictionary *dataDic11=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"varchar(50),",@"name",@"integer,",@"age",@"varchar(50)",@"mobile", nil];
//    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath=[array objectAtIndex:0];
//    
//    filePath =[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",databaseName]];
//    
//    NSFileManager *manager=[NSFileManager defaultManager];
//    
//    BOOL success = NO;
//    if ([manager fileExistsAtPath:filePath])
//    {
//        success =YES;
//    }
//    if (!success)
//    {
//        NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",databaseName]];
//        [manager copyItemAtPath:path2 toPath:filePath error:nil];
//    }
//    sqlite3_stmt *createStmt=nil;
//    sqlite3 *database;
//    if (sqlite3_open([filePath UTF8String], &database) == SQLITE_OK)
//    {
//        if (createStmt == nil)
//        {
//            NSString *attributeString =[[NSString alloc] init];
//            for (NSString *key in attributeDic)
//            {
//                NSString *attributeSetting =[NSString stringWithFormat:@"%@ %@",key,[attributeDic valueForKey:key]];
//                attributeString = [attributeString stringByAppendingString:[NSString stringWithFormat:@"%@",attributeSetting]];
//            }
//            NSString *query=[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",tableName,attributeString];
//            
//            if (sqlite3_prepare_v2(database, [query UTF8String], -1, &createStmt, NULL) != SQLITE_OK)
//            {
//                sqlite3_finalize(createStmt);
//                sqlite3_close(database);
//                return NO;
//            }
//            sqlite3_exec(database, [query UTF8String], NULL, NULL, NULL);
//            sqlite3_finalize(createStmt);
//            sqlite3_close(database);
//            return YES;
//        }
//    }
//    return YES;
//}
//
////////////////////////////////////////////////////////////////////
/////////39. insert values in table in sqlite file        //////////
////////////////////////////////////////////////////////////////////
//+(BOOL)insertValuesInSqliteTable:(NSString *) databaseName attributes :(NSMutableDictionary *)attributeDic tableName :(NSString *)tableName
//{
//    /// How to pass Attribute Dic:
//    /*  NSMutableDictionary *dataDic1=[[NSMutableDictionary alloc] init];
//    [dataDic setValue:@"'kumar'," forKey:@"name,"];
//    [dataDic setValue:@"'30'," forKey:@"age,"];
//    [dataDic setValue:@"'+9897812149'" forKey:@"mobile"];*/
//    
//    BOOL databaseResponse=NO;
//    NSString *databaseResponseString;
//    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath=[array objectAtIndex:0];
//    
//    filePath =[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",databaseName]];
//    NSFileManager *manager=[NSFileManager defaultManager];
//    
//    BOOL success = NO;
//    if ([manager fileExistsAtPath:filePath])
//    {
//        success = YES;
//    }
//    if (!success)
//    {
//        NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",databaseName]];
//        [manager copyItemAtPath:path2 toPath:filePath error:nil];
//    }
//    
//    sqlite3 *database;
//    sqlite3_stmt *compiledStatement = nil;
//    
//    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK)
//    {
//        NSString *attributeStringName =[[NSString alloc] init];
//        NSString *attributeStringValues =[[NSString alloc] init];
//
//        for (NSString *key in attributeDic)
//        {
//            NSString *attributeName =[NSString stringWithFormat:@"%@,",key];
//            
//            NSString *attributeValuse =[NSString stringWithFormat:@"'%@',",[attributeDic valueForKey:key]];
//            if (attributeValuse.length<=0)
//               attributeValuse=@"";
//                
//            attributeStringName = [attributeStringName stringByAppendingString:[NSString stringWithFormat:@"%@",attributeName]];
//            attributeStringValues = [attributeStringValues stringByAppendingString:[NSString stringWithFormat:@"%@",attributeValuse]];
//        }
//        attributeStringName = [attributeStringName substringToIndex:[attributeStringName length]-1];
//        attributeStringValues = [attributeStringValues substringToIndex:[attributeStringValues length]-1];
//        
//        NSString *query=[NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableName,attributeStringName,attributeStringValues];
//        
//        sqlite3_reset(compiledStatement);
//        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &compiledStatement, NULL) != SQLITE_OK)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
//            databaseResponse=NO;
//        }
//        if (sqlite3_step(compiledStatement) != SQLITE_DONE)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
//            databaseResponse=NO;
//        }
//        if(sqlite3_step(compiledStatement) == SQLITE_DONE)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"Successfully done."];
//            databaseResponse=YES;
//        }
//        sqlite3_finalize(compiledStatement);
//        sqlite3_close(database);
//    }
//    else
//    {
//        NSLog(@"Data Base has some problem to open");
//        databaseResponse=NO;
//    }
//    
//     NSLog(@"database resposne :- %@",databaseResponseString);
//    if (databaseResponseString.length<=0)
//        databaseResponse=YES;
//    
//    return databaseResponse;
//}
//
////////////////////////////////////////////////////////////////////
/////////40. update values in table from sqlite file      //////////
////////////////////////////////////////////////////////////////////
//+(BOOL)updateValuesInSqliteTable:(NSString *) databaseName attributes :(NSMutableDictionary *)attributeDic tableName :(NSString *)tableName condition:(NSString *)condition
//{
//    /*
//     NSMutableDictionary *dataDic=[[NSMutableDictionary alloc] init];
//     [dataDic setValue:@"'tahir'," forKey:@"name"];
//     [dataDic setValue:@"'200'" forKey:@"age"];
//     NSString *condition =[NSString stringWithFormat:@"where name = 'mithun'"];*/
//    
//    BOOL databaseResponse=NO;
//    NSString *databaseResponseString;
//    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath=[array objectAtIndex:0];
//    
//    filePath =[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",databaseName]];
//    NSFileManager *manager=[NSFileManager defaultManager];
//    
//    BOOL success = NO;
//    if ([manager fileExistsAtPath:filePath])
//    {
//        success =YES;
//    }
//    if (!success)
//    {
//        NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",databaseName]];
//        [manager copyItemAtPath:path2 toPath:filePath error:nil];
//    }
//    
//    sqlite3 *database;
//    sqlite3_stmt *compiledStatement = nil;
//    
//    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK)
//    {
//        NSString *attributeString =[[NSString alloc] init];
//        
//        for (NSString *key in attributeDic)
//        {
//            NSString *attributeName =[NSString stringWithFormat:@"%@ = %@",key,[attributeDic valueForKey:key]];
//            attributeString = [attributeString stringByAppendingString:[NSString stringWithFormat:@"%@",attributeName]];
//        }
//        
//        NSString *query=[NSString stringWithFormat:@"UPDATE  %@ SET %@ %@",tableName,attributeString,condition];
//        
//        sqlite3_reset(compiledStatement);
//        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &compiledStatement, NULL) != SQLITE_OK)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
//            databaseResponse=NO;
//        }
//        if (sqlite3_step(compiledStatement) != SQLITE_DONE)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
//            databaseResponse=NO;
//        }
//        if(sqlite3_step(compiledStatement) == SQLITE_DONE)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"Successfully done."];
//            databaseResponse=YES;
//        }
//        sqlite3_finalize(compiledStatement);
//        sqlite3_close(database);
//    }
//    else
//    {
//        NSLog(@"Data Base has some problem to open");
//        databaseResponse=NO;
//    }
//
//    if ([databaseResponseString isEqualToString:@"(null)"])
//        databaseResponse=YES;
//    
//    return databaseResponse;
//}
//
////////////////////////////////////////////////////////////////////
/////////41. fetch data from sqlite table                 //////////
////////////////////////////////////////////////////////////////////
//+(NSMutableArray *)fetchDataFromSqliteTable:(NSString *) databaseName query :(NSString *)query tableName :(NSString *)tableName
//{
//    NSMutableArray *dataArray=[[NSMutableArray alloc] init];
//    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath=[array objectAtIndex:0];
//    
//    filePath =[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",databaseName]];
//    NSFileManager *manager=[NSFileManager defaultManager];
//    
//    BOOL success = NO;
//    if ([manager fileExistsAtPath:filePath])
//    {
//        success =YES;
//    }
//    if (!success)
//    {
//        NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",databaseName]];
//        [manager copyItemAtPath:path2 toPath:filePath error:nil];
//    }
//    NSMutableArray *tableColumn =[MyCustomClass getAllColumnFromSqliteTable:query databaseFilePath:filePath];
//    
//    sqlite3 *database;
//    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK)
//    {
//        sqlite3_stmt *compiledStatement;
//        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
//        {
//            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
//            {
//                NSMutableDictionary *tableDataDic =[[NSMutableDictionary alloc] init];
//                for (int i=0; i<tableColumn.count; i++)
//                {
//                    NSString *value = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement,i)];
//                    if ([value length]==0)
//                    {
//                        [tableDataDic setValue:@"" forKey:[tableColumn objectAtIndex:i]];
//                    }
//                    else
//                    {
//                        [tableDataDic setValue:value forKey:[tableColumn objectAtIndex:i]];
//                    }
//                }
//                [dataArray addObject:tableDataDic];
//            }
//        }
//        sqlite3_finalize(compiledStatement);
//    }
//    sqlite3_close(database);
//    return dataArray;
//}
//
////////////////////////////////////////////////////////////////////
/////////42. get all table attributs/ column              //////////
////////////////////////////////////////////////////////////////////
//+(NSMutableArray *)getAllColumnFromSqliteTable:(NSString *)query databaseFilePath :(NSString *)databaseFilePath
//{
//    NSMutableArray *tableColumn=[[NSMutableArray alloc] init];
//    sqlite3 *database;
//    sqlite3_stmt *compiledStatement = nil;
//    
//    if(sqlite3_open([databaseFilePath UTF8String], &database) == SQLITE_OK)
//    {
//        //NSString *query=[NSString stringWithFormat:@"pragma table_info ('%@')",tableName];
//        sqlite3_reset(compiledStatement);
//        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
//        {
//            int count =(int )sqlite3_column_count(compiledStatement);
//            for(int i=0;i<count;i++)
//            {
//                NSString *columnName = [NSString stringWithUTF8String:(char *)sqlite3_column_name(compiledStatement,i)];
//                if (columnName==0)
//                {
//                    [tableColumn addObject:@""];
//                }
//                else
//                {
//                    [tableColumn addObject:columnName];
//                }
//            }
//        }
//        sqlite3_finalize(compiledStatement);
//        sqlite3_close(database);
//    }
//    return tableColumn;
//}
//
////////////////////////////////////////////////////////////////////
/////////43. delete item from table attributs/column      //////////
////////////////////////////////////////////////////////////////////
//+(BOOL )deleteItemFromSqliteTable:(NSString *)databaseName tableName :(NSString *)tableName condition:(NSString *)condition
//{
//    //DELETE from tableName WHERE id=3
//    //DELETE FROM tableName          for all row deleting.
//    BOOL databaseResponse=NO;
//    NSString *databaseResponseString;
//    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath=[array objectAtIndex:0];
//    
//    filePath =[filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",databaseName]];
//    NSFileManager *manager=[NSFileManager defaultManager];
//    
//    BOOL success = NO;
//    if ([manager fileExistsAtPath:filePath])
//    {
//        success =YES;
//    }
//    if (!success)
//    {
//        NSString *path2=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite",databaseName]];
//        [manager copyItemAtPath:path2 toPath:filePath error:nil];
//    }
//    sqlite3 *database;
//    sqlite3_stmt *compiledStatement = nil;
//    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK)
//    {
//        NSString *query=nil;
//        if (condition.length>0)
//            query=[NSString stringWithFormat:@"DELETE from %@ WHERE %@",tableName,condition];
//        else
//            query=[NSString stringWithFormat:@"DELETE from %@",tableName];
//        
//        sqlite3_reset(compiledStatement);
//        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &compiledStatement, NULL) != SQLITE_OK)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
//            databaseResponse=NO;
//        }
//        if (sqlite3_step(compiledStatement) != SQLITE_DONE)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"%s",sqlite3_errmsg(database)];
//            databaseResponse=NO;
//        }
//        if(sqlite3_step(compiledStatement) == SQLITE_DONE)
//        {
//            databaseResponseString=[NSString stringWithFormat:@"Successfully done."];
//            databaseResponse=YES;
//        }
//        sqlite3_finalize(compiledStatement);
//        sqlite3_close(database);
//    }
//    else
//    {
//        NSLog(@"Data Base has some problem to open");
//        databaseResponse=NO;
//    }
//    NSLog(@"database resposne :- %@",databaseResponseString);
//    return databaseResponse;
//}

#pragma mark - WebService Helper Method List
//////////////////////////////////////////////////////////////////
///////44. JSON Data In Dictionary                      //////////
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary*)dictionaryFromJSON :(NSData *)response
{
    NSError *jsonError=nil;
    NSMutableDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&jsonError];
   // NSLog(@"all keys>>%@",[[[parsedJSON objectForKey:@"info"] firstObject] allKeys] );
    //[dict allKeys]
    if (jsonError!=nil)
    {
        [parsedJSON removeAllObjects];
        [parsedJSON setValue:jsonError forKey:@"JSONERROR"];
    }
    return parsedJSON;
}

//////////////////////////////////////////////////////////////////
///////45.Save Data in Array after getting JSON response     /////
//////////////////////////////////////////////////////////////////
+(NSMutableArray*)jsonArray :(NSData*)response
{
    NSError *jsonError=nil;
    //NSMutableArray *parsedJSON = [[NSMutableArray alloc] init] ;
    NSMutableArray *parsedJSON = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonError];
    if (jsonError!=nil)
    {
        [parsedJSON removeAllObjects];
        [parsedJSON setValue:jsonError forKey:@"JSONERROR"];
    }
    return parsedJSON;
}


#pragma mark - Progress View Method List
//////////////////////////////////////////////////////////////////
///////46.Progress View with showing message                 /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressViewWithShowingMessage :(NSString *)stringMessage
{
    [SVProgressHUD showWithStatus:stringMessage maskType:SVProgressHUDMaskTypeGradient];
}

//////////////////////////////////////////////////////////////////
///////47.Progress View withDismiss error message            /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageDismissWithError :(NSString *)stringMessage timeDalay :(float ) timeDalay
{
    [SVProgressHUD dismissWithError:stringMessage afterDelay:timeDalay];
}

//////////////////////////////////////////////////////////////////
///////48. Progress View dismiss with successfully message   /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageDismissWithSuccess :(NSString *)stringMessage timeDalay :(float ) timeDalay
{
    [SVProgressHUD dismissWithSuccess:stringMessage afterDelay:timeDalay];
}

//////////////////////////////////////////////////////////////////
///////49. Progress View Immediate Dismiss                   /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageWithImmediateDismiss
{
    [SVProgressHUD dismiss];
}

//////////////////////////////////////////////////////////////////
///////50. show with progress view                           /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageWithProgressView: (NSString *)stringMessage
{
    [SVProgressHUD showWithStatus:@"Alert !" maskType:SVProgressHUDMaskTypeBlack indicatorType:SVProgressHUDIndicatorTypeProgressBar networkIndicator:YES];
}

//////////////////////////////////////////////////////////////////
///////51. show with progress view with subtitle             /////
//////////////////////////////////////////////////////////////////
+(void)SVProgressMessageShowWithSubtitle:(NSString *)title subtitle:(NSString *)subtitle
{
    [SVProgressHUD showWithStatus:title subtitle:subtitle maskType:SVProgressHUDMaskTypeBlack indicatorType:SVProgressHUDIndicatorTypeSpinner];
}


#pragma mark - Miscellaneous Method List
//////////////////////////////////////////////////////////////////
///////52.get color from hex string                          /////
//////////////////////////////////////////////////////////////////
+(UIColor *)getColorFromHexColorString:(NSString *)hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) return [UIColor grayColor];
        
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        
        if ([cString length] != 6) return  [UIColor grayColor];
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)  
                               alpha:1.0f];  
}

//////////////////////////////////////////////////////////////////
//////53.Move View according to textfild  appear or diappear  ////
//////////////////////////////////////////////////////////////////
+(void)moveViewAccordingToTextFild:(UIView *)yourView moveOption:(BOOL)move //TEST Remaining
{
    CGRect rect = yourView.frame;
    if (move)
    {
        rect.origin.y -= 40;
        rect.size.height += 40 ;
        
    }
    else
    {
        rect.origin.y =0 ;
        rect.size.height =460 ;
    }
    yourView.frame = rect;
}

//////////////////////////////////////////////////////////////////
//////54. Set image on left side of textfeild                 ////
//////////////////////////////////////////////////////////////////
+(void)setImageOnLeftCornerOfTextField :(UITextField *)searchField imageToAdd:(UIImage *)imageToAdd
{
    /// this is always depend on the image size
    searchField.leftView = [[UIImageView alloc] initWithImage:imageToAdd];
    searchField.leftViewMode = UITextFieldViewModeAlways;
}

//////////////////////////////////////////////////////////////////
//////55. Set image on right side of textfeild                ////
//////////////////////////////////////////////////////////////////
+(void)setImageOnRightCornerOfTextField :(UITextField *)searchField imageToAdd:(UIImage *)imageToAdd
{
    /// this is always depend on the image size
    searchField.rightView = [[UIImageView alloc] initWithImage:imageToAdd];
    searchField.rightViewMode = UITextFieldViewModeAlways;
}

//////////////////////////////////////////////////////////////////
//////56. Drow border on any view                             ////
//////////////////////////////////////////////////////////////////
+(void)drawBorderOnAnyView:(UIView*)view radius:(CGFloat)radius
{
    [view.layer setCornerRadius:radius];
    [view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [view.layer setBorderWidth:1.2f];
}

//////////////////////////////////////////////////////////////////
//////57. Drow border on any view with color                  ////
//////////////////////////////////////////////////////////////////
+(void)drawBorderOnAnyViewWtihColor:(UIView*)view radius:(CGFloat)radius borderColor:(UIColor *)borderColor
{
    [view.layer setCornerRadius:radius];
    [view.layer setBorderColor:borderColor.CGColor];
    [view.layer setBorderWidth:1.2f];
}

//////////////////////////////////////////////////////////////////
//////58. Drow border on any view with color and width        ////
//////////////////////////////////////////////////////////////////
+(void)drawBorderOnAnyViewWtihColorAndWidth:(UIView*)view radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth
{
    [view.layer setCornerRadius:radius];
    [view.layer setBorderColor:borderColor.CGColor];
    [view.layer setBorderWidth:borderWidth];
}

//////////////////////////////////////////////////////////////////
//////59. Save Image in Photo library               ////
//////////////////////////////////////////////////////////////////
+(void)saveImageInPhotoLibrary:(NSString*)filePath
{
    UIImage *image =[UIImage imageWithContentsOfFile:filePath];
    UIImageWriteToSavedPhotosAlbum(image,
                                   self,@selector(thisImage:hasBeenSavedInPhotoAlbumWithError:usingContextInfo:),
                                   NULL);
}
- (void)thisImage:(UIImage *)image hasBeenSavedInPhotoAlbumWithError:(NSError *)error usingContextInfo:(void*)ctxInfo
{
    if (error)
    {
    }
    else
    {
    }
}

//////////////////////////////////////////////////////////////////
//////60. Save Video in Photo library               ////
//////////////////////////////////////////////////////////////////
+(void)saveVideoToPhotoLibrary:(NSString*)filePath
{
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(filePath))
    {
        UISaveVideoAtPathToSavedPhotosAlbum(filePath, self, @selector(video:didFinishSavingWithError:contextInfo:), (__bridge void *)(filePath));
    }
}

-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error == nil)
    {
        [MyCustomClass SVProgressMessageDismissWithSuccess:@"Done." timeDalay:1.0];
    }
    [MyCustomClass SVProgressMessageDismissWithError:@"Ahaa ! Please try again." timeDalay:1.0];
}

//////////////////////////////////////////////////////////////////
//////61. Create a circuler imageview               ////
//////////////////////////////////////////////////////////////////
+(void)setViewWithCirculerBorder:(UIView *)view
{
    /// view should be Square for complete circuler
    view.layer.cornerRadius = view.frame.size.height /2;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 0;
}

//////////////////////////////////////////////////////////////////
//////62. Convert normal string to hex decimal string         ////
//////////////////////////////////////////////////////////////////
+ (NSString *) stringToHex:(NSString *)normalString
{
    NSUInteger len = [normalString length];
    unichar *chars = malloc(len * sizeof(unichar));
    [normalString getCharacters:chars];
    NSMutableString *hexString = [[NSMutableString alloc] init];
    for(NSUInteger i = 0; i < len; i++ )
    {
        [hexString appendString:[NSString stringWithFormat:@"%x", chars[i]]];
    }
    free(chars);
    return hexString;
}

//////////////////////////////////////////////////////////////////
//////63. speaking text using siri                            ////
//////////////////////////////////////////////////////////////////
+(void)speakOfGivenText:(NSString *)textString
{
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:textString];
    if (NSTextAlignmentRight)
    {
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ar-SA"];
    }
    [utterance setRate:0.2f];
    [synthesizer speakUtterance:utterance];
    // for other language go in iphonemithun.blogspot.com
}

//////////////////////////////////////////////////////////////////
//////64. Set thumbnail size of any image                     ////
//////////////////////////////////////////////////////////////////
+(UIImage *)setThumbnailSizeOfAnyImage:(CGSize)thumbSize forImage:(UIImage*)image
{
    UIGraphicsBeginImageContext(thumbSize);
    [image drawInRect:CGRectMake(0,0,thumbSize.width,thumbSize.height)];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;
}

//////////////////////////////////////////////////////////////////
//////65. Get video Thumbnail image                           ////
//////////////////////////////////////////////////////////////////
+(UIImage *)generateVideoThumbNailImage :(NSString *)filepath
{
    NSURL *videoURL = [NSURL URLWithString:filepath] ;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform=TRUE;
    NSError *err = NULL;
    CMTime time = CMTimeMake(25, 5);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    return [[UIImage alloc] initWithCGImage:imgRef];
}

//////////////////////////////////////////////////////////////////
//////66. File size calculation                               ////
//////////////////////////////////////////////////////////////////
+(NSString *)calculateSizeOfFile:(NSString *)filePath
{
    NSError *error=nil;
    long int fileSize = (long int)[[[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error] fileSize];
    if (error!=nil)
        return @"";
    /// works only with documents folder files
    if(fileSize>0)
    {
        long int sizeINKB=fileSize/1000;
        if(sizeINKB<=0)
        {
            return [NSString stringWithFormat:@"%ld Bytes",fileSize];
        }
        long int sizeINMB=sizeINKB/1000;
        long int pointINMB=sizeINKB%1000;
        if(sizeINMB<=0)
        {
            return [NSString stringWithFormat:@"%ld KB",sizeINKB];
        }
        return [NSString stringWithFormat:@"%ld.%2ld MB",sizeINMB,pointINMB];
    }
    return @"";
}

//////////////////////////////////////////////////////////////////
//////67. getting sim service provider name                   ////
//////////////////////////////////////////////////////////////////
+(NSString *)getSimServiceProviderName
{
    CTTelephonyNetworkInfo *netinfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [netinfo subscriberCellularProvider];
    NSLog(@"Carrier Name: %@", [carrier carrierName]);    
    return [carrier carrierName];
}

//////////////////////////////////////////////////////////////////
//////68. getting device serial number                        ////
//////////////////////////////////////////////////////////////////
+(NSString *)getDeviceSerialNumber
{
    NSString *serialNumber = nil;
    void *IOKit = dlopen("/System/Library/Frameworks/IOKit.framework/IOKit", RTLD_NOW);
    if (IOKit)
    {
        mach_port_t *kIOMasterPortDefault = dlsym(IOKit, "kIOMasterPortDefault");
        CFMutableDictionaryRef (*IOServiceMatching)(const char *name) = dlsym(IOKit, "IOServiceMatching");
        mach_port_t (*IOServiceGetMatchingService)(mach_port_t masterPort, CFDictionaryRef matching) = dlsym(IOKit, "IOServiceGetMatchingService");
        CFTypeRef (*IORegistryEntryCreateCFProperty)(mach_port_t entry, CFStringRef key, CFAllocatorRef allocator, uint32_t options) = dlsym(IOKit, "IORegistryEntryCreateCFProperty");
        kern_return_t (*IOObjectRelease)(mach_port_t object) = dlsym(IOKit, "IOObjectRelease");
        
        if (kIOMasterPortDefault && IOServiceGetMatchingService && IORegistryEntryCreateCFProperty && IOObjectRelease)
        {
            mach_port_t platformExpertDevice = IOServiceGetMatchingService(*kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));
            if (platformExpertDevice)
            {
                CFTypeRef platformSerialNumber = IORegistryEntryCreateCFProperty(platformExpertDevice, CFSTR("IOPlatformSerialNumber"), kCFAllocatorDefault, 0);
                if (CFGetTypeID(platformSerialNumber) == CFStringGetTypeID())
                {
                    serialNumber = [NSString stringWithString:(__bridge NSString*)platformSerialNumber];
                    CFRelease(platformSerialNumber);
                }
                IOObjectRelease(platformExpertDevice);
            }
        }
        dlclose(IOKit);
    }
    return serialNumber;
}

//////////////////////////////////////////////////////////////////
//////69. getting device Local IP Address number              ////
//////////////////////////////////////////////////////////////////
+(NSString*)getDeviceLocalIPAddress
{
    NSString *address = Nil;
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr);
                //if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:interface])
                
                if([name isEqualToString:@"en1"])
                {
                    // Get NSString from C String
                    wifiAddress = addr; //[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
                else if([name isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    wifiAddress = addr; //[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
                else if([name isEqualToString:@"pdp_ip0"])
                {
                    // Interface is the cell connection on the iPhone
                    cellAddress = addr;
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    address = wifiAddress ? wifiAddress : cellAddress;
    address = address ? address : @"0.0.0.0";
    NSLog(@"LocalIP: %@",address);
    return address;
}

//////////////////////////////////////////////////////////////////
//////70. getting device Mac Address number              ////
//////////////////////////////////////////////////////////////////
+(NSString*)getDeviceMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    return macAddressString;
}

//////////////////////////////////////////////////////////////////
//////71. remove white space from url string                  ////
//////////////////////////////////////////////////////////////////
+(NSString *)removeWhiteSpaceFromURLString:(NSString*)insertString
{
    NSString  *urlString = [insertString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    return urlString;
}

//////////////////////////////////////////////////////////////////
//////72. break a string in parts using spacific charector    ////
//////////////////////////////////////////////////////////////////
+(NSArray *) seprateStringFromStringWithSpacificKeyValue:(NSString *)insertString seperatedfromsign:(NSString *)seperatedfromsign
{
    //NSArray *dataArray =[[NSArray alloc] init];
    NSArray *dataArray=[insertString componentsSeparatedByString:seperatedfromsign];
    return dataArray;
}

//////////////////////////////////////////////////////////////////
//////73. Move any left to right or right to left direction   ////
//////////////////////////////////////////////////////////////////
+(void)moveAnyViewInLeftRightDirection :(UIView *)view2 leftDirection:(int)directionValue movingDistance:(float)movingDistance
{
    // left to right = 0;
    // right to left = 1;
    CGRect viewFrame = view2.frame;
    viewFrame.origin.x -= movingDistance * (directionValue? 1: -1);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.00];
    view2.frame = viewFrame;
    [UIView commitAnimations];
}

//////////////////////////////////////////////////////////////////
//////74. Move any up to down or down to up direction         ////
//////////////////////////////////////////////////////////////////
+(void)moveAnyViewInUpDownDirection :(UIView *)view2 leftDirection:(int)directionValue movingDistance:(float)movingDistance
{
    // up to down = 0;
    // down to up = 1;
    CGRect viewFrame = view2.frame;
    viewFrame.origin.y -= movingDistance * (directionValue? 1: -1);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:1.00];
    view2.frame = viewFrame;
    [UIView commitAnimations];
}

//////////////////////////////////////////////////////////////////
//////75 .Rotate any view from left to right direction        ////
//////////////////////////////////////////////////////////////////
+(void)rotateAnyViewInLeftRightDirection :(UIView *)view direction:(int)direction
{
    // direction = -1 for right to left
    // direction = 1 for left to right
    float directionInFloat = ((360*M_PI)/180)*direction;
    float kFloatCount = 3.4028235E+38;
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:directionInFloat];
    fullRotation.duration = 6;
    fullRotation.repeatCount = kFloatCount;
    [view.layer addAnimation:fullRotation forKey:@"360"];
}

//////////////////////////////////////////////////////////////////
//////76 .Stop Rotation view animation                  //////////
//////////////////////////////////////////////////////////////////
+(void)rotationAnimationStop :(UIView *)view
{
    //float kFloatCount = 3.4028235E+38;
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((1))];
    fullRotation.duration = 0;//6;
    fullRotation.repeatCount = 0;
    [view.layer addAnimation:fullRotation forKey:@"360"];
}

//////////////////////////////////////////////////////////////////
//////77 .Char of string replace from other char               ///
//////////////////////////////////////////////////////////////////
+(NSString *)stringCharReplaceByOtherChar :(NSString*)insertString replacedBy:(NSString *)replacedBy replaceOf:(NSString *)replaceOf
{
    NSString  *urlString = [insertString stringByReplacingOccurrencesOfString:replaceOf withString:replacedBy];
    return urlString;
}

//////////////////////////////////////////////////////////////////
//////78 .trim Mobile number /// ////// // / //                ///
//////////////////////////////////////////////////////////////////
+(NSString*)trimMobileNumber:(NSString*)mobileNumber
{
    //remove these characters + - space ( )
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    unichar breakChar=0x00a0;
    NSString *noBreakSpace = [NSString stringWithFormat:@"%C", breakChar];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:noBreakSpace withString:@""];
    return mobileNumber;
}

//////////////////////////////////////////////////////////////////
//////79 .set color on image  // ////// // / //                ///
//////////////////////////////////////////////////////////////////
+(UIImage*)colorOnImage:(UIImage *)image withColor:(UIColor *)color
{
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(image.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

//////////////////////////////////////////////////////////////////
//////80 .Convert into mp 4 file type / // / //                /// //TEST remaining
//////////////////////////////////////////////////////////////////
+(void)convertInToMp4:(NSURL*)sourceURL targetPath:(NSString*)targetPath asyncHandler:(void (^)(void))handler
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceURL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality])
    {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        exportSession.outputURL = [NSURL fileURLWithPath:targetPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        CMTime start = CMTimeMakeWithSeconds(1.0, 600);
        
        CMTime duration = CMTimeMakeWithSeconds(3.0, 600);
        
        CMTimeRange range = CMTimeRangeMake(start, duration);
        range=range;
        [exportSession exportAsynchronouslyWithCompletionHandler:handler];
    }
}

//////////////////////////////////////////////////////////////////
//////81 .factor width with constant height of any view     /// //
//////////////////////////////////////////////////////////////////
+(CGFloat)factoredWidthForHeightConstant:(CGFloat)heightConstant size:(CGSize)size
{
    CGFloat factoredWidth = (heightConstant * size.width)/size.height;
    return factoredWidth;
}

//////////////////////////////////////////////////////////////////
//////82 .factor height with constant width of any view     /// //
//////////////////////////////////////////////////////////////////
+(CGFloat)factoredHeightForWidthConstant:(CGFloat)widthConstant size:(CGSize)size
{
    CGFloat factoredheight = (widthConstant * size.height)/size.width;
    return factoredheight;
}

//////////////////////////////////////////////////////////////////
//////83 .get time of video                                 /// //
//////////////////////////////////////////////////////////////////
+(NSString *)getVideoTimeDuration:(NSString *) videoPath
{
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:videoPath];
    AVURLAsset *sourceAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    CMTime duration = sourceAsset.duration;
    int videoDurationSeconds = CMTimeGetSeconds(duration);
    // Log("%d",videoDurationSeconds%60);
    NSString *formattedText = [NSString stringWithFormat:@"%d:%.2d",videoDurationSeconds/60,videoDurationSeconds%60];
    return formattedText;
}

//////////////////////////////////////////////////////////////////
////// 84.         sorting array                       ///    ////
//////////////////////////////////////////////////////////////////
+(NSArray *) getSortedArray : (NSMutableArray *)unSortedArray
{
    NSArray * sortedKeys =
    [unSortedArray sortedArrayUsingComparator:^(id string1, id string2)
     {
         return [((NSString *)string1) compare:((NSString *)string2)
                                       options:NSNumericSearch];
     }];
    return sortedKeys;
}

//////////////////////////////////////////////////////////////////
////// 85.         Write video from imagess            ///    ////
//////////////////////////////////////////////////////////////////
+(void)writeVideoFromImages:(NSMutableArray *)imageArray audioFileName:(NSString *)audioFileName videoFileName:(NSString *)videoFileName videoFrameSize:(CGSize )videoFrameSize
{
    NSString *documentsDirectory = [NSHomeDirectory()
                                    stringByAppendingPathComponent:@"Documents"];
    NSString *videoFilePath = [documentsDirectory stringByAppendingPathComponent:videoFileName];
    
    NSString *bundleDirectory = [[NSBundle mainBundle] bundlePath];
    NSString *audioFilePath = [bundleDirectory stringByAppendingPathComponent:audioFileName];
    
    ////////* Video file settings *///////
    
    CGSize imageSize = CGSizeMake(640, 1136);//videoFrameSize; // video frame with height and width
    NSError *error=nil;
    AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:
                                  [NSURL fileURLWithPath:videoFilePath] fileType:AVFileTypeQuickTimeMovie
                                                              error:&error];
    NSParameterAssert(videoWriter);
    
    NSDictionary *videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                   AVVideoCodecH264, AVVideoCodecKey,
                                   [NSNumber numberWithInt:imageSize.width], AVVideoWidthKey,
                                   [NSNumber numberWithInt:imageSize.height], AVVideoHeightKey,
                                   nil];
    
    AVAssetWriterInput* videoWriterInput = [AVAssetWriterInput
                                            assetWriterInputWithMediaType:AVMediaTypeVideo
                                            outputSettings:videoSettings];
    
    AVAssetWriterInputPixelBufferAdaptor *adaptor = [AVAssetWriterInputPixelBufferAdaptor
                                                     assetWriterInputPixelBufferAdaptorWithAssetWriterInput:videoWriterInput
                                                     sourcePixelBufferAttributes:nil];
    
    NSParameterAssert(videoWriterInput);
    NSParameterAssert([videoWriter canAddInput:videoWriterInput]);
    videoWriterInput.expectsMediaDataInRealTime = YES;
    [videoWriter addInput:videoWriterInput];
    
    //Start a session:
    [videoWriter startWriting];
    [videoWriter startSessionAtSourceTime:kCMTimeZero];
    CVPixelBufferRef buffer = NULL;
    
    NSLog(@"*******************End Video Settings*******************************");
    
    int frameCount = 0;
    double numberOfSecondsPerFrame = 2; // time duration for single image.
    NSUInteger fps = 30;
    double frameDuration = fps*numberOfSecondsPerFrame;
    
    for(UIImage * img in imageArray)
    {
        buffer = [MyCustomClass pixelBufferFromCGImage:[img CGImage] imageFrame:imageSize];
        
        BOOL append_ok = NO;
        int j = 0;
        while (!append_ok && j < fps)
        {
            if (adaptor.assetWriterInput.readyForMoreMediaData)
            {
                CMTime frameTime = CMTimeMake(frameCount*frameDuration,(int32_t) fps);
                append_ok = [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
                [NSThread sleepForTimeInterval:0.05];
                if(!append_ok)
                {
                    NSError *videoError = videoWriter.error;
                    if(error!=nil)
                    {
                        NSLog(@"Unresolved error %@,%@.", videoError, [videoError userInfo]);
                    }
                }
            }
            else
            {
                printf("adaptor not ready %d, %d\n", frameCount, j);
                [NSThread sleepForTimeInterval:0.1];
            }
            j++;
        }
        if (!append_ok)
        {
            printf("error appending image %d times %d\n, with error.", frameCount, j);
        }
        frameCount++;
    }
    NSLog(@"********************** End Vedio From Images ****************************");
    //Finish the session:
    [videoWriterInput markAsFinished];
    CMTime frameTime = CMTimeMake(imageArray.count*frameDuration,(int32_t) fps);
    [videoWriter endSessionAtSourceTime:frameTime];
    [videoWriter finishWritingWithCompletionHandler:^{
    }];
    [MyCustomClass writeAudioFileInVideoFile:audioFilePath videoFilePath:videoFilePath];
    NSLog(@"********************** End Audio Writing in Vidoe file ****************************");
}

//////////////////////////////////////////////////////////////////
////// 86.         add image on pixelBuffer            ///    ////
//////////////////////////////////////////////////////////////////
+ (CVPixelBufferRef) pixelBufferFromCGImage: (CGImageRef) image imageFrame:(CGSize)size
{
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGImageCompatibilityKey,
                             [NSNumber numberWithBool:YES], kCVPixelBufferCGBitmapContextCompatibilityKey,
                             nil];
    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          size.width,
                                          size.height,
                                          kCVPixelFormatType_32ARGB,
                                          (__bridge CFDictionaryRef) options,
                                          &pxbuffer);
    if (status != kCVReturnSuccess){
        NSLog(@"Failed to create pixel buffer");
    }
    
    CVPixelBufferLockBaseAddress(pxbuffer, 0);
    void *pxdata = CVPixelBufferGetBaseAddress(pxbuffer);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pxdata, size.width,
                                                 size.height, 8, 4*size.width, rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    //kCGImageAlphaNoneSkipFirst);
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(0));
    CGContextDrawImage(context, CGRectMake(0, 0, CGImageGetWidth(image),
                                           CGImageGetHeight(image)), image);
    CGColorSpaceRelease(rgbColorSpace);
    CGContextRelease(context);
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);
    return pxbuffer;
}

//////////////////////////////////////////////////////////////////
////// 87.         write audio in video file           ///    ////
//////////////////////////////////////////////////////////////////
+(void)writeAudioFileInVideoFile :(NSString *)audioFilePath videoFilePath:(NSString *)videoFilePath
{
    ////////////////////////////////////////////////////////////////////////////
    //////////////  OK now add an audio file to move file  /////////////////////
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    NSURL    *audio_inputFileUrl = [NSURL fileURLWithPath:audioFilePath];
    NSURL    *video_inputFileUrl = [NSURL fileURLWithPath:videoFilePath];
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // create the final video output file as MOV file - may need to be MP4, but this works so far...
    NSString *outputFilePath = [documentsDirectory stringByAppendingPathComponent:@"final_video.mp4"];
    NSURL    *outputFileUrl = [NSURL fileURLWithPath:outputFilePath];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:outputFilePath])
        [[NSFileManager defaultManager] removeItemAtPath:outputFilePath error:nil];
    
    CMTime nextClipStartTime = kCMTimeZero;
    
    AVURLAsset* videoAsset = [[AVURLAsset alloc]initWithURL:video_inputFileUrl options:nil];
    CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
    AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:nextClipStartTime error:nil];
    
    AVURLAsset* audioAsset = [[AVURLAsset alloc]initWithURL:audio_inputFileUrl options:nil];
    CMTimeRange audio_timeRange = CMTimeRangeMake(kCMTimeZero, audioAsset.duration);
    AVMutableCompositionTrack *b_compositionAudioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    [b_compositionAudioTrack insertTimeRange:audio_timeRange ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:nextClipStartTime error:nil];
    
    AVAssetExportSession* _assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    _assetExport.outputFileType = @"public.mpeg-4";
    _assetExport.outputURL = outputFileUrl;
    
    [_assetExport exportAsynchronouslyWithCompletionHandler:
     ^(void ) {
         //[self saveVideoToAlbum:outputFilePath];
     }
     ];
    NSLog(@"DONE.....outputFilePath--->%@", outputFilePath);
}

//////////////////////////////////////////////////////////////////
////// 88.         Capture device screen shot          ///    ////
//////////////////////////////////////////////////////////////////
+(NSData *)takeaScreenShot:(UIViewController *)viewController
{
    UIGraphicsBeginImageContext(viewController.view.bounds.size);
    [viewController.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData * data = UIImageJPEGRepresentation(image,1.0);
    return data;
}

//////////////////////////////////////////////////////////////////
////// 89.         Add Water mark on image             ///    ////
//////////////////////////////////////////////////////////////////
+(UIImage *)addWaterMarkOnImage :(UIImage *) normalImage waterMarkString:(NSString *)waterMarkString viewController:(UIViewController *) viewController
{
    int w = viewController.view.frame.size.width;
    int h = viewController.view.frame.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), normalImage.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);
    char* text = (char *)[waterMarkString cStringUsingEncoding:NSASCIIStringEncoding];
    
    CGContextSelectFont(context, "Georgia", 200, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 0, 0, .091);
    CGContextSetTextMatrix(context, CGAffineTransformMakeRotation( 3*M_PI_2/2 ));
    CGContextShowTextAtPoint(context, 1000, 100, text, strlen(text));
    
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
}

//////////////////////////////////////////////////////////////////
////// 90.        Load  multiple Image on UIImageView   //    ////
//////////////////////////////////////////////////////////////////
+(void)loadMultiplaImagesOnImageVeiwWithAnimation:(UIImageView *)imageView imageArray:(NSMutableArray *)imageArray
{
    // imageArray should be collection of image objects /
    imageView.animationImages = imageArray;
    imageView.animationDuration = 0.5f;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    // For Stop animation  [imageView stopAnimating];
}

//////////////////////////////////////////////////////////////////
////// 91.        Remove html data from json data       //    ////
//////////////////////////////////////////////////////////////////
+ (NSString *)removeHtmlFromJsondata: (NSString *) html
{
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString: html];
    while ([theScanner isAtEnd] == NO)
    {
        [theScanner scanUpToString: @"<" intoString: NULL];
        // find end of tag
        [theScanner scanUpToString: @">" intoString: &text];
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat: @"%@>", text] withString: @" "];
    }
    return html;
}

//////////////////////////////////////////////////////////////////
////// 92.        Remove null data from nsmutabledictionary   ////
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary *)removeNullValueFromDictionary:(NSMutableDictionary *)dictionary

{
    dictionary=[[NSMutableDictionary alloc]init];
    for (NSString *key in [dictionary allKeys])
    {
        id nullString = [dictionary objectForKey:key];
        if ([nullString isKindOfClass:[NSDictionary class]])
        {

            [MyCustomClass removeNullValueFromDictionary:(NSMutableDictionary*)nullString];
        }
        else
        {
            if ((NSString*)nullString == (id)[NSNull null])
                [dictionary setValue:@"" forKey:key];
           // [dictionary mutableCopy];
        }
    }
    return dictionary;
}

+(NSMutableDictionary*)getValuesWithOutNull:(NSDictionary
                                             *)yourDictionary
{
    NSMutableDictionary *replaced = [NSMutableDictionary
                                     dictionaryWithDictionary: yourDictionary];
    id nul = [NSNull null];
    NSString *blank = @"";
    
    for (NSString *key in yourDictionary) {
        const id object = [yourDictionary objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        }
        else if ([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject:[self getValuesWithOutNull:object]
                         forKey:key];
        }
        else if([object isKindOfClass: [NSArray class]])
        {
            NSMutableArray *array  = [NSMutableArray
                                      arrayWithArray:object];
            for(int i = 0 ;i < array.count;i++)
            {
                NSDictionary *dict = [array objectAtIndex:i];
                [array replaceObjectAtIndex:i withObject:[self 
                                                          getValuesWithOutNull:dict]];
            }
            [replaced setObject:array forKey:key];
        }
    }
    return  replaced;
    
}



//////////////////////////////////////////////////////////////////
////// 93.       File size in G_K_M_BYTE    / / / // / / /    ////
//////////////////////////////////////////////////////////////////
+(NSString *)sizeIn_G_K_M_Byte:(long long)sizeINGMKB
{
    if(sizeINGMKB>0)
    {
        long long sizeINKB= sizeINGMKB/1000;
        if(sizeINKB<=0)
        {
            return [NSString stringWithFormat:@"%lld Bytes",sizeINGMKB];
        }
        long long sizeINMB=sizeINKB/1000;
        long long pointINMB=sizeINKB%1000;
        if(sizeINMB<=0)
        {
            return [NSString stringWithFormat:@"%lld KB",sizeINKB];
        }
        long long sizeINGB=sizeINMB/1000;
        long long
        pointINGB=sizeINMB%1000;
        if(sizeINGB<=0)
        {
            return [NSString stringWithFormat:@"%lld.%2lld MB",sizeINMB,pointINMB];
        }
        return [NSString stringWithFormat:@"%lld.%2lld GB",sizeINGB,pointINGB];
    }
    return @"No Space";
}

//////////////////////////////////////////////////////////////////
////// 94.      Device memory info          / / / // / / /    ////
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary *)getDeviceMemory
{
    long long memorySize = 0.0f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc] init];
    
    if (dictionary)
    {
        NSNumber *freeMemoryInBytes = [dictionary objectForKey: NSFileSystemFreeSize];
        memorySize = [freeMemoryInBytes longLongValue];
        [dic setValue:[MyCustomClass sizeIn_G_K_M_Byte:memorySize] forKey:@"Free_Memory"];
        
        NSNumber *allMemoryizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        memorySize = [allMemoryizeInBytes longLongValue];
        [dic setValue:[MyCustomClass sizeIn_G_K_M_Byte:memorySize] forKey:@"Total_Memory"];
        
        //NSNumber *usedMemorySizeInBytes = [dictionary objectForKey: NSFileSystemFreeSize];
        memorySize = [allMemoryizeInBytes longLongValue] - [freeMemoryInBytes longLongValue];
        [dic setValue:[MyCustomClass sizeIn_G_K_M_Byte:memorySize] forKey:@"Used_Memory"];
    }
    return dic;
}




#pragma mark - Layout Method List
//////////////////////////////////////////////////////////////////
////// 100. Get Current Loaded ViewController on Window        ///
//////////////////////////////////////////////////////////////////
+(UIViewController *)activeViewControllerOnWindow
{
    AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIViewController *vcRoot = [appDelegate.window rootViewController];
    UIViewController *vcActive = nil;
    UIViewController* presentedViewController = nil;
    
    if([vcRoot isKindOfClass:[UITabBarController class]])
    {
        vcActive = ((UINavigationController*)((UITabBarController*)vcRoot).selectedViewController).topViewController;
        if(vcActive == nil)
        {
            vcActive = (((UITabBarController*)vcRoot).moreNavigationController.topViewController);
        }
        presentedViewController = vcActive.presentedViewController;
        if(presentedViewController)
            vcActive = presentedViewController;
    }
    else
        vcActive = ((UINavigationController*)vcRoot).topViewController;
    
    return vcActive;
}

//////////////////////////////////////////////////////////////////
////// 101. custom label view/// / / /// // / // / // /        ///
//////////////////////////////////////////////////////////////////
+(UILabel *)customLabelView: (float)xaxis yaxis: (float)yaxis width: (float)width height: (float)height labelTitle: (NSString *)labelTitle fontStyle: (NSString *)fontStyle fontColor:(UIColor *)fontColor fontSize:(float)fontSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xaxis,yaxis, width, height)];
    [label setText:labelTitle];
    label.font = [UIFont fontWithName:fontStyle size:fontSize];
    label.textColor = fontColor;
    label.textAlignment = NSTextAlignmentCenter;
    [label setBackgroundColor:[UIColor clearColor]];
    return label;
}

//////////////////////////////////////////////////////////////////
////// 102. custom textField      // / / /// // / /// /        ///
//////////////////////////////////////////////////////////////////
+(UITextField *) customTextField :(float)xaxis yaxis: (float) yaxis width: (float)width height: (float)height placeholder: (NSString *)placeholder
{
    UITextField *myText = [[UITextField alloc] initWithFrame:CGRectMake(xaxis, yaxis, width, height)];
    [myText setPlaceholder:placeholder];
    [myText setBorderStyle:UITextBorderStyleBezel];
    return myText;
    
}

//////////////////////////////////////////////////////////////////
//////103. My Custome textview with rounded shape             ////
//////////////////////////////////////////////////////////////////
+(UITextView *)customTextView :(NSString *) textData xaxis: (float )xaxis yaxis: (float )yaxis width: (float )width :(float )height fontSize:(float)fontSize fontStyle: (NSString *)fontStyle
{
    UITextView *yourTextView = [[UITextView alloc] initWithFrame:CGRectMake	(xaxis, yaxis, width, height)];
    [yourTextView setFont:[UIFont fontWithName:fontStyle size:fontSize]];
    [yourTextView setTextAlignment:NSTextAlignmentCenter];
    [yourTextView setEditable:NO];
    yourTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [yourTextView sizeToFit];
    [yourTextView setText:textData];
    return yourTextView;
}

//////////////////////////////////////////////////////////////////
//////104. My Custome ImageView with rounded shape             ////
//////////////////////////////////////////////////////////////////
+(UIImageView *)customImage :(float)xaxis yaxis:(float) yaxis width:(float)width height:(float)height imageName:(UIImage *)image
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(xaxis,yaxis, width,height)];
    backgroundImage.image = image;
    return backgroundImage;
}

//////////////////////////////////////////////////////////////////
//////105. My Custom button  add with view                    ////
//////////////////////////////////////////////////////////////////
+(UIButton *) customButton :(float)xaxis yaxis:(float) yaxis width:(float)width height:(float)height buttonTitle:(NSString *)buttonTitle backgroundImage:(NSString *)backgroundImage selectedImage:(NSString*)selectedImage
{
    UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myButton.frame = CGRectMake(xaxis, yaxis, width, height);
    [myButton setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    [myButton setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateSelected];
    [myButton setTitle:buttonTitle forState:UIControlStateNormal];
    return myButton;
}

//////////////////////////////////////////////////////////////////
//////106. right custom bar button                            ////
//////////////////////////////////////////////////////////////////
+(UIBarButtonItem *)customRightBarButton:(SEL)action target:(id)target title:(NSString *)title width:(float) width
{
    UIButton* customButton = [UIButton buttonWithType:UIButtonTypeCustom]; // left-pointing shape!
    customButton.frame = CGRectMake(0.f,0.0f,width,30.0f);
    [customButton setTitleColor:[UIColor colorWithRed:5/255.0 green:122/255.0 blue:251/255.0 alpha:1.0]  forState:UIControlStateNormal];
    customButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customButton.titleLabel.textAlignment= NSTextAlignmentLeft;
    [customButton setTitle:title forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton] ;
    return rightBarButtonItem;
}

//////////////////////////////////////////////////////////////////
//////107. left custom bar button                            ////
//////////////////////////////////////////////////////////////////
+(UIBarButtonItem *)customLeftBarButtonItem:(SEL)action target:(id)target title:(NSString *)title width:(float) width
{
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom]; // left-pointing shape!
    customButton.frame = CGRectMake(0.0f,0.0f,width,35.0f);
    [customButton setTitleColor:[UIColor colorWithRed:5/255.0 green:122/255.0 blue:251/255.0 alpha:1.0]  forState:UIControlStateNormal];
    customButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
    customButton.titleEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    customButton.titleLabel.textAlignment= NSTextAlignmentLeft;
    [customButton setTitle:NSLocalizedString(title,nil) forState:UIControlStateNormal];
    UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
    return leftBarButtonItem;
}

//////////////////////////////////////////////////////////////////
//////108. device is ipad or iphone                           ////
//////////////////////////////////////////////////////////////////
+(BOOL)deviceIsiPad
{
    BOOL isPad;
    NSRange range = [[[UIDevice currentDevice] model] rangeOfString:@"iPad"];
    if(range.location==NSNotFound)
    {
        isPad=NO;
    }
    else
    {
        isPad=YES;
    }
    return isPad;
}

//////////////////////////////////////////////////////////////////
//////109. device information                                 ////
//////////////////////////////////////////////////////////////////
+(NSMutableDictionary *)getDeviceInformation
{
    NSMutableDictionary *infoDic=[[NSMutableDictionary alloc] init];
    [infoDic setValue:[[UIDevice currentDevice] systemVersion] forKey:@"SystemVersion"];
    [infoDic setValue:[[UIDevice currentDevice] model] forKey:@"Model"];
    [infoDic setValue:[[UIDevice currentDevice] systemName] forKey:@"SystemName"];
    [infoDic setValue:[[UIDevice currentDevice] localizedModel] forKey:@"LocalizedModel"];
    [infoDic setValue:[[UIDevice currentDevice] name] forKey:@"Name"];
    return infoDic;
}

#pragma mark - Gesture Method List
//////////////////////////////////////////////////////////////////
//////110. LongPress gesture                                  ////
//////////////////////////////////////////////////////////////////
+(void)addLongPressGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    [view addGestureRecognizer:recognizer];
}

//////////////////////////////////////////////////////////////////
//////111.SwipGestureFromLeftToRight gesture                  ////
//////////////////////////////////////////////////////////////////
+(void)addSwipGestureFromLeftToRight:(UIView *)view action:(SEL)action target:(id)target
{
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:rightRecognizer];
}

//////////////////////////////////////////////////////////////////
//////112.SwipGestureFromRightToLeft gesture                  ////
//////////////////////////////////////////////////////////////////
+(void)addSwipGestureFromRightToLeft:(UIView *)view action:(SEL)action target:(id)target
{
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:action];
    leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [leftRecognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:leftRecognizer];
}

//////////////////////////////////////////////////////////////////
//////113.SingleTabGesture gesture                            ////
//////////////////////////////////////////////////////////////////
+(void)addSingleTabGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [singleTapRecognizer setNumberOfTouchesRequired:1];
    [view addGestureRecognizer:singleTapRecognizer];
}

//////////////////////////////////////////////////////////////////
//////114. DoubleTabGesture gesture                           ////
//////////////////////////////////////////////////////////////////
+(void)addDoubleTabGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [doubleTapRecognizer setNumberOfTouchesRequired:2];
    [view addGestureRecognizer:doubleTapRecognizer];
}

//////////////////////////////////////////////////////////////////
//////115. TripleTabGesture gesture                           ////
//////////////////////////////////////////////////////////////////
+(void)addTripleTabGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UITapGestureRecognizer *tripleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [tripleTapRecognizer setNumberOfTouchesRequired:2];
    [view addGestureRecognizer:tripleTapRecognizer];
}

//////////////////////////////////////////////////////////////////
//////116. PinchGesture gesture                               ////
//////////////////////////////////////////////////////////////////
+(void)addPinchGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:target action:action];
    [pinchRecognizer setDelegate:target];
    [view addGestureRecognizer:pinchRecognizer];
}

//////////////////////////////////////////////////////////////////
//////117. RotationGesture gesture                            ////
//////////////////////////////////////////////////////////////////
+(void)addRotationGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:target action:action];
    [rotationRecognizer setDelegate:target];
    [view addGestureRecognizer:rotationRecognizer];
}

//////////////////////////////////////////////////////////////////
//////118. PanGesture gesture                                 ////
//////////////////////////////////////////////////////////////////
+(void)addPanGesture:(UIView *)view action:(SEL)action target:(id)target
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:target];
    [view addGestureRecognizer:panRecognizer];
}


//////////////////////////////////////////////////////////////////
//////////////////                                  //////////////
/////*******************************************************//////
//////////////////      End Class method            //////////////
//////////////////////////////////////////////////////////////////



+(NSString *)appDateFormate:(NSString *)dateString
{
    NSString *appDate = @"No Date";
    int dateYear = 0;
    NSString *dateMonth = @"";
    NSString *dateDay = @"";
    NSArray *tempArray = [MyCustomClass seprateStringFromStringWithSpacificKeyValue:dateString seperatedfromsign:@" "];

    if (tempArray.count>0)
    {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *appointmentDate = [[NSDate alloc] init];
        appointmentDate = [dateFormat dateFromString:[tempArray objectAtIndex:0]];
        
        dateMonth = [MyCustomClass getCurrentMonthInName:appointmentDate];
        dateYear = [MyCustomClass getCurrentYear:appointmentDate];
        dateDay = [MyCustomClass getCurrentDayInNumber:appointmentDate];
        
        dateMonth=[dateMonth substringToIndex:3];
        
        appDate =[NSString stringWithFormat:@"%@ %@, %d",dateMonth,dateDay,dateYear];
    }
    
    return appDate;
}

+(BOOL)isThisPastDate:(NSString *)dateString
{
    BOOL isPastDate = YES;
    NSArray *tempArray = [MyCustomClass seprateStringFromStringWithSpacificKeyValue:dateString seperatedfromsign:@" "];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *enteredDate = [dateFormat dateFromString:[tempArray objectAtIndex:0]];
    
    NSDate * today = [NSDate date];
    NSComparisonResult result = [today compare:enteredDate];
    switch (result)
    {
        case NSOrderedAscending:
            return NO;
            break;
        case NSOrderedDescending:
            return YES;
            break;
        case NSOrderedSame:
            return YES; //Not sure why This is case when null/wrong date is passed
            break;
        default:
            return YES;
            break;
    }
    return isPastDate;
}



/////*******************************************************//////
/////*******************************************************//////
/////*******************************************************//////
/////*******************************************************//////

#pragma mark - Delegate Method Structure Only
//////////////////////////////////////////////////////////////////
//////1 .AlertView delegate method using in class where you want//
//////////////////////////////////////////////////////////////////
+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex :(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"])
    {
        ///what you want to do alertview delegate method when click on alert button.
        // this method you on this class where you want to add alert delegate method.
    }
    NSString *textFieldValue = [alertView textFieldAtIndex:0].text;
    NSLog(@"%@", textFieldValue);
}


//////////////////////////////////////////////////////////////////
//////GEt User Uploaded Profile Pic                                 ////
//////////////////////////////////////////////////////////////////

//+(UIImage*)loadImage
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                      [NSString stringWithString: [historyModel sharedhistoryModel].UserPicName] ];
//    UIImage* image = [UIImage imageWithContentsOfFile:path];
//    return image;
//}

//
+(void)saveImage:(UIImage*)image {
    NSLog(@"saveImage");
//    NSData *userInfoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserInfo"];
//    NSDictionary *userInfo = [NSKeyedUnarchiver unarchiveObjectWithData:userInfoData];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"amar.png"];
    // UIImage *image = ; // imageView is my image from camera
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:YES];
}


+ (UIImage *)scaleAndRotateImage:(UIImage *) image {
    int kMaxResolution = 320;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

+ (NSString*)getDeviceID
{
    NSString * deviceId = @"";
    if ([UIPasteboard pasteboardWithName:@"UDID" create:NO]) {
        deviceId = [[[UIPasteboard pasteboardWithName:@"UDID" create:NO] string] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    else {
        CFUUIDRef theUUID = CFUUIDCreate(NULL);
        CFStringRef string = CFUUIDCreateString(NULL, theUUID);
        deviceId = [(__bridge NSString*)string stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:@"UDID" create:YES];
        [pasteboard setPersistent:YES];
        [pasteboard setString:deviceId];
    }
    return deviceId;
}



@end
