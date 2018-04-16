//
//  Util.h
//  AdvanceFit
//
//  Created by LeeJaeYong on 2016. 3. 28..
//  Copyright © 2016년 LeeJaeYong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Util : NSObject

+ (void)showAlerView:(id)BaseView title:(NSString *)alerttitle message:(NSString *)alertMessage;
+ (NSString *)getToday;
+ (NSString *)getaweekAgo;
+ (UIColor *)colorWithHexString:(NSString *)colorString;
+ (NSDate *)convertStringToDate:(NSString *)date;
+ (NSString*)stringDateFromDate:(NSDate*)date;
+ (NSArray *)sortedArray:(NSArray *)arr;
+ (NSString*)stringMonthFromDate:(NSDate*)date;
+ (NSDate *)getaMonthAgo:(NSDate *)currentDate;
+ (NSDate *)getaMonthNext:(NSDate *)currentDate;
+ (NSDate *)convertStringToMonthDate:(NSString *)date;
+ (NSDate *)convertStringToMonthDayDate:(NSString *)date;
+ (NSString*)stringDateFromMonthDate:(NSDate*)date;
+ (NSDate *)convertStringToYearDate:(NSString *)date;
+ (NSString*)stringDateFromYearDate:(NSDate*)date;
+ (NSString *)getMoveDate:(NSDate *)date move:(NSInteger)moveDay;
+ (NSString *)getDayoftheWeek:(NSDate *)date;
+ (NSDate *)convertStringToDateWithNotSlash:(NSString *)date;
+ (NSString *)convertDateToStringWithNotSlash:(NSDate *)date;

@end
