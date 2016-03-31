//
//  DateModel.m
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/3.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel

#pragma mark - current time
/*!返回今天日期,例如:11月3日 星期三*/
+ (NSString *)returnCurrentDate {
    NSString *date = [NSString stringWithFormat:@"%ld月%ld日 %@", [self returnCurrentMonth], [self returnCurrentDay], [self returnCurrentWeekdayWithIndex:-1]];
    return date;
}

/*!返回当年, 例如:2014*/
+ (NSInteger)returnCurrentYear {
    NSInteger year = [[self returnDateComponents] year];
    return year;
}

/*!返回当月,例如:11*/
+ (NSInteger)returnCurrentMonth {
    NSInteger month = [[self returnDateComponents] month];
    return month;
}

/*!返回当日,例如:3*/
+ (NSInteger)returnCurrentDay {
    NSInteger day = [[self returnDateComponents] day];

    
    return day;
}

/*!返回今天星期几,例如 星期二*/
+ (NSString *)returnCurrentWeekdayWithIndex:(NSInteger)index {
    NSString *week = nil;
    NSInteger weekday = [[self returnDateComponents] weekday];
    
    if (index<0) {
        week = [self returnWeekdayWithWeekday:weekday];
    }else {
        if (weekday+index>7) {
            week = [self returnWeekdayWithWeekday:weekday+index-7];
        }else {
            week = [self returnWeekdayWithWeekday:weekday + index];
        }
    }
    
    return week;
}

/*!识别当日星期几编号,例如:3 => 星期二*/
+ (NSString *)returnWeekdayWithWeekday:(NSInteger)weekday {
    NSString *week = nil;
    
    if (weekday==1) {
        week = @"星期日";
    }else if(weekday == 2){
        week = @"星期一";
    }else if(weekday == 3){
        week = @"星期二";
    }else if(weekday == 4){
        week = @"星期三";
    }else if(weekday == 5){
        week = @"星期四";
    }else if(weekday == 6){
        week = @"星期五";
    }else if(weekday == 7){
        week = @"星期六";
    }else {
        XXZLog(@"星期几的识别出错...");
    }
    
    return week;
}

/*!返回当前几时了,例如:10*/
+ (NSInteger)returnCurrentHour {
    NSInteger hour = [[self returnDateComponents] hour];
    return hour;
}

/*!返回当前几分了,例如:12*/
+ (NSInteger)returnCurrentMinute {
    NSInteger minute = [[self returnDateComponents] minute];
    return minute;
}

/*!返回当前几秒了,例如:17*/
+ (NSInteger)returnCurrentSecond {
    NSInteger second = [[self returnDateComponents] second];
    return second;
}

/*!返回时间成分*/
+ (NSDateComponents *)returnDateComponents {
    NSDate *now = [NSDate date]; //获取当前时间
    
    NSCalendar *calendar = [NSCalendar currentCalendar];//获取日历
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    return dateComponent;
}

@end
