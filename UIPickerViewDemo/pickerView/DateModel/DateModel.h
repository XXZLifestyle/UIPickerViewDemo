//
//  DateModel.h
//  UIPickerViewDemo
//
//  Created by Jiayu_Zachary on 15/11/3.
//  Copyright © 2015年 Zachary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject

/*!返回今天日期,例如:11月3日 星期三*/
+ (NSString *)returnCurrentDate;
/*!返回当年, 例如:2014*/
+ (NSInteger)returnCurrentYear;
/*!返回当月,例如:11*/
+ (NSInteger)returnCurrentMonth;
/*!返回当日,例如:3*/
+ (NSInteger)returnCurrentDay;
/*!返回今天星期几,例如 星期二
    index<0, 获取今天星期几
    index>=0, 获取未来(包含今天)一周星期
 */
+ (NSString *)returnCurrentWeekdayWithIndex:(NSInteger)index;
/*!返回当前几时了,例如:10*/
+ (NSInteger)returnCurrentHour;
/*!返回当前几分了,例如:12*/
+ (NSInteger)returnCurrentMinute;
/*!返回当前几秒了,例如:17*/
+ (NSInteger)returnCurrentSecond;

@end
