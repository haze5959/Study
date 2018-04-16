//
//  Util.m
//  AdvanceFit
//
//  Created by LeeJaeYong on 2016. 3. 28..
//  Copyright © 2016년 LeeJaeYong. All rights reserved.
//

#import "Util.h"
#import <UIKit/UIAlertController.h>

@implementation Util

+ (void)showAlerView:(id)BaseView title:(NSString *)alerttitle message:(NSString *)alertMessage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alerttitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [BaseView presentViewController:alert animated:YES completion:nil];
}

+ (NSString *)getToday{
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [DateFormatter stringFromDate:[NSDate date]];
}

+ (NSDate *)convertStringToDateWithNotSlash:(NSString *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:date];
    return dateFromString;
}

// Ryu Add
+ (NSString *)convertDateToStringWithNotSlash:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)convertStringToDate:(NSString *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:date];
    return dateFromString;
}

+ (NSDate *)convertStringToYearDate:(NSString *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:date];
    return dateFromString;
}


+ (NSDate *)convertStringToMonthDate:(NSString *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:date];
    return dateFromString;
}

+ (NSDate *)convertStringToMonthDayDate:(NSString *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"MM.dd"];
    NSDate *dateFromString = [[NSDate alloc] init];
    // voila!
    dateFromString = [dateFormatter dateFromString:date];
    return dateFromString;
}


+ (NSString*)stringDateFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

+ (NSString*)stringDateFromYearDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}


+ (NSString*)stringDateFromMonthDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

+ (NSString*)stringMonthFromDate:(NSDate*)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *stringMonth = [dateFormatter stringFromDate:date];
    return stringMonth;
}

+ (NSString *)getaweekAgo{
    NSDate *sevenDaysAgo = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                    value:-7
                                                                   toDate:[NSDate date]
                                                                  options:0];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [DateFormatter stringFromDate:sevenDaysAgo];
}

+ (NSString *)getMoveDate:(NSDate *)date move:(NSInteger)moveDay{
    NSDate *sevenDaysAgo = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay
                                                                    value:moveDay
                                                                   toDate:date
                                                                  options:0];
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    return [DateFormatter stringFromDate:sevenDaysAgo];
}


+ (NSDate *)getaMonthAgo:(NSDate *)currentDate{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = -1;
    NSDate *currentDateMinus1Month = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    return currentDateMinus1Month;
}

+ (NSDate *)getaMonthNext:(NSDate *)currentDate{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = 1;
    NSDate *currentDatePlus1Month = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
    
    return currentDatePlus1Month;

}

+ (UIColor *)colorWithHexString:(NSString *)colorString
{
    colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    if (colorString.length == 3)
        colorString = [NSString stringWithFormat:@"%c%c%c%c%c%c",
                       [colorString characterAtIndex:0], [colorString characterAtIndex:0],
                       [colorString characterAtIndex:1], [colorString characterAtIndex:1],
                       [colorString characterAtIndex:2], [colorString characterAtIndex:2]];
    
    if (colorString.length == 6)
    {
        int r, g, b;
        sscanf([colorString UTF8String], "%2x%2x%2x", &r, &g, &b);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0];
    }
    
    if (colorString.length == 8)
    {
        int r, g, b, a;
        sscanf([colorString UTF8String], "%2x%2x%2x%2x", &r, &g, &b, &a);
        return [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a/255.0)];
    }
    return nil;
}

+(NSArray *)sortedArray:(NSArray *)arr{
    NSArray *sortedArray = [arr sortedArrayUsingComparator:
                           ^(id obj1, id obj2) {
                               return [obj2 compare:obj1]; // note reversed comparison here
                           }];
    return sortedArray;
}

+(NSString *)getDayoftheWeek:(NSDate *)date{
    NSDateFormatter *myFormatter = [[NSDateFormatter alloc] init];
    [myFormatter setDateFormat:@"EEEE"]; // day, like "Saturday"
    [myFormatter setDateFormat:@"c"]; // day number, like 7 for saturday
    
    NSString *dayOfWeek = [myFormatter stringFromDate:date];
    
    int iDay = [dayOfWeek intValue];
    switch (iDay) {
        case 1:
            dayOfWeek = @"일";
            break;
        case 2:
            dayOfWeek = @"월";
            break;
        case 3:
            dayOfWeek = @"화";
            break;
            
        case 4:
            dayOfWeek = @"수";
            break;
            
        case 5:
            dayOfWeek = @"목";
            break;
            
        case 6:
            dayOfWeek = @"금";
            break;
            
        case 7:
            dayOfWeek = @"토";
            break;
        default:
            break;
    }
    
    return dayOfWeek;
}

@end
