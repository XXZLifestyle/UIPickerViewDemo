//
//  ShowDateModel.m
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/3.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import "ShowDateModel.h"
#import "DateModel.h"

#define MAX_MINUTE 55
#define MIN_MINUTE 0
#define MAX_HOUR 19
#define MIN_HOUR 8
#define INTERNAL_TIME 30

@implementation ShowDateModel

/*!
    定位到当前时间,然后延后30分钟
    返回0 小时,1 分钟, 2 日期 数据源
 */
+ (NSArray *)showCurrentDate {
    NSInteger hour = [DateModel returnCurrentHour];
    NSInteger minute = [DateModel returnCurrentMinute];
    NSMutableArray *dayArr = [self returnOneWeekWithType:0];//日期默认值
    
//    //测试
//    hour = 19;
//    minute = 26;
    
    if (hour <= MIN_HOUR || hour >= MAX_HOUR) {//小时不在范围内<=8 || >=19
        
        if (hour == MIN_HOUR-1) {//h=7
            if (minute+INTERNAL_TIME>=MAX_MINUTE) {//m+30>=55
                hour = MIN_HOUR;//8
                
                //考虑到刚好60分
                //                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = (minute+INTERNAL_TIME-MAX_MINUTE)/5;
                //                minute = minute*5 + tempM;
                minute = minute*5;
                
            }else {
                hour = MIN_HOUR;//8
                minute = MIN_MINUTE;//0
            }
        }else if (hour == MIN_HOUR) {//h=8
            if (minute+INTERNAL_TIME>=MAX_MINUTE) {//m+30>=55
                hour = MIN_HOUR+1;//9
                
                //                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = (minute+INTERNAL_TIME-MAX_MINUTE)/5;
                //                minute = minute*5 + tempM;
                minute = minute*5;
            }else {
                hour = MIN_HOUR;//8
                
                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = minute/5;
                minute = minute*5+tempM+INTERNAL_TIME;
            }
            
        }else if (hour == MAX_HOUR) {//h=19;
            if (minute+INTERNAL_TIME>=MAX_MINUTE) {//m+30>=55
                hour = MIN_HOUR;//9
                minute = MIN_MINUTE;//0
                
                //当hour = 19,minute+30 >= 55时
                //日期跳转到第二天
                [dayArr removeAllObjects];
                dayArr = [self returnOneWeekWithType:1];
                
            }else {
                hour = MAX_HOUR;//19
                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = minute/5;
                minute = minute*5+tempM+INTERNAL_TIME;
            }
        }
        
        else {//分钟不在最早或最晚临界值 及 小时最大临界值与小时不在范围内的取值
            hour = MIN_HOUR;//8
            minute = MIN_MINUTE;//0
        }
        
    }else {//在小时范围内
        if (hour == MAX_HOUR-1) {//h=18
            if (minute+INTERNAL_TIME>=MAX_MINUTE) {//m+30>=55
                //超过当晚最晚时间,跳转到第二天8点0分
                hour = hour+1;//19
                
                //                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = (minute+INTERNAL_TIME-MAX_MINUTE)/5;
                //                minute = minute*5+tempM;
                
                minute = minute*5;
            }else {
                //小时就是当前的小时
                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = minute/5;
                minute = minute*5+tempM+INTERNAL_TIME;
            }
            
        }else {//正常时间
            if (minute+INTERNAL_TIME>=MAX_MINUTE) {//m+30>=55
                hour = hour+1;//
                
                //                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = (minute+INTERNAL_TIME-MAX_MINUTE)/5;
                //                minute = minute*5 + tempM;
                
                minute = minute*5;
            }else {
                //小时就是当前小时
                //分钟
                NSInteger tempM = [self addFiveMinuteWithMinute:minute];
                minute = minute/5;
                minute = minute*5+tempM+INTERNAL_TIME;
            }
        }
    }
    
    NSMutableArray *minuteArr = [self setMinuteOrHourWithParameter:minute type:0];
    NSMutableArray *hourArr = [self setMinuteOrHourWithParameter:hour type:1];
    
    return @[hourArr, minuteArr, dayArr];
}

/*!
 获取日期数据源,例如:11月3日 星期三
 type = 0, 正常一周时间
 type = 1, 最晚时间临界值时间
 */
+ (NSMutableArray *)returnOneWeekWithType:(NSInteger)type {
    NSMutableArray *weekArr = [NSMutableArray array];
    
    if (type == 0) {
        for (int i=0; i<7; i++) {
            
            if (i<2) {//今天,明天
                if (i==0) {
                    [weekArr addObject:@"今天"];
                }else {
                    [weekArr addObject:@"明天"];
                }
            }else {
                NSDate *senddate = [[NSDate date] dateByAddingTimeInterval:86400*i];
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                //日期格式
                [dateformatter setDateFormat:@"MM月dd日"];
//                [dateformatter setDateFormat:@"YYYY-MM-dd"];
//                [dateformatter setDateFormat:@"YYYY-MM"];
//                [dateformatter setDateFormat:@"MM-dd"];
//                [dateformatter setDateFormat:@"YYYY年MM月dd日"];
//                [dateformatter setDateFormat:@"YYYY年MM月"];
                
                NSString *week = [DateModel returnCurrentWeekdayWithIndex:i];
                
                [weekArr addObject:[NSString stringWithFormat:@"%@ %@",[dateformatter stringFromDate:senddate],week]];
            }
        }
    }else if (type == 1) {
        for (int i=1; i<8; i++) {
            
            if (i<3) {//今天,明天
                if (i==1) {
                    [weekArr addObject:@"明天"];
                }else {
                    [weekArr addObject:@"后天"];
                }
            }else {
                NSDate *senddate = [[NSDate date] dateByAddingTimeInterval:86400*i];
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                
                [dateformatter setDateFormat:@"MM月dd日"];
                NSString *week = [DateModel returnCurrentWeekdayWithIndex:i];
                
                [weekArr addObject:[NSString stringWithFormat:@"%@ %@",[dateformatter stringFromDate:senddate],week]];
            }
        }
    }else {
        XXZLog(@"参数输入错误,请重新输入...");
    }
    
    return weekArr;
}

/*!如果不足5分钟,加上五分钟*/
+ (NSInteger)addFiveMinuteWithMinute:(NSInteger)minute {
    //多余的+5分钟
    int tempMinu = minute%5;
    if (tempMinu == 0) {
        tempMinu = 0;
    }else {
        tempMinu = 5;
    }
    
    return tempMinu;
}

/*! 给分钟小时重新赋值
 type => 0:分钟, 1:小时
 type=0 => x代表分钟的倍数(55>=x>=0)
 type=1 => x代表小时(19>=x>=8)
 */
+ (NSMutableArray *)setMinuteOrHourWithParameter:(NSInteger)x type:(NSInteger)type {
    NSMutableArray *dataArr = [NSMutableArray array];
    
    if (type == 0) {//分钟重新赋值
        //x是5的倍数    //max => 0~11, 分钟默认最大 12个
        if (x%5 == 0 && x>=MIN_MINUTE && x<=MAX_MINUTE) {//分钟的取值条件及范围
            
            for (NSInteger i=x/5; i<=MAX_MINUTE/5; i++) {//含最大值
                [dataArr addObject:[NSString stringWithFormat:@"%ld分", i*5]];
            }
            
        }else {
            XXZLog(@"输入的参数不符合条件...");
        }
    }else if (type == 1) {//小时重新赋值
        if (x>=MIN_HOUR && x<=MAX_HOUR) {//小时的取值范围
            for (NSInteger i=x; i<=MAX_HOUR; i++) {//含最大值
                [dataArr addObject:[NSString stringWithFormat:@"%ld点", i]];
            }
        }
        
    }else {
        XXZLog(@"参数输入错误,请重新输入...");
    }
    
    return dataArr;
}

@end
