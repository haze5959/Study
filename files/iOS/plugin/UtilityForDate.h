//
//  ViewController.h
//  camera test
//
//  Created by 권오규 on 2016. 12. 22..
//  Copyright © 2016년 권오규. All rights reserved.
//

#import

@interface UtilityForDate : NSObject

- (NSString *)_getDateWithDateFormat:(NSString *)format;
- (NSInteger)_getDayOfWeek;

+ (NSString *)getToday;
+ (NSString *)getTodayMonth;
+ (NSString *)getTodayYear;
+ (NSString *)getTodayWithDateFormat:(NSString *)format;
+ (NSTimeInterval)getTodayTimeStamp;
+ (NSString *)getDateFromTimestamp:(NSTimeInterval)timestamp dateDisplayType:(NSString *)dateType;
+ (NSInteger)getIntegerTodayOfWeek;
+ (NSString *)getStringTodayOfWeek;

@end
