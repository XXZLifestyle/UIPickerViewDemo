//
//  ShowDateModel.h
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/3.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowDateModel : NSObject

/*!
 定位到当前时间,然后延后30分钟
 返回0 小时,1 分钟, 2 日期 数据源
 */
+ (NSArray *)showCurrentDate;

/*!
 获取日期数据源,例如:11月3日 星期三
 type = 0, 正常一周时间
 type = 1, 最晚时间临界值时间
 */
+ (NSMutableArray *)returnOneWeekWithType:(NSInteger)type;

/*! 给分钟小时重新赋值
 type => 0:分钟, 1:小时
 type=0 => x代表分钟的倍数(55>=x>=0)
 type=1 => x代表小时(19>=x>=8)
 */
+ (NSMutableArray *)setMinuteOrHourWithParameter:(NSInteger)x type:(NSInteger)type;

@end
