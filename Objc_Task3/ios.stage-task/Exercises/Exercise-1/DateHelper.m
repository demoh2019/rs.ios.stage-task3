#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
    if (monthNumber>12 || monthNumber<1){
        return nil;
    }
    NSDateFormatter *month = [NSDateFormatter new];
    return [[month monthSymbols] objectAtIndex:monthNumber-1];
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSDateFormatter *dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    NSDate *convert = [dateFormat dateFromString:date];
    if(convert == nil){
        return 0;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateDay = [gregorian components:NSCalendarUnitDay fromDate:convert];
    return [dateDay day];
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    NSDateFormatter *week = [NSDateFormatter new];
    [week setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    [week setDateFormat:@"EE"];
    return [week stringFromDate:date];
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    NSDateComponents *toDay = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:[NSDate date]];
    NSInteger toDayWeek = [toDay weekOfYear];
    NSDateComponents *toDayS = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:date];
    NSInteger toDayWeekS = [toDayS weekOfYear];
    if (toDayWeek == toDayWeekS){
        return YES;
    }
    return NO;
}

@end
