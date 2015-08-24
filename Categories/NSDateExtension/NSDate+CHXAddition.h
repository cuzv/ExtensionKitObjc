//
//  NSDate+CHXAddition.h
//  WildAppExtensionRunner
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@interface NSDate (CHXAddition)

// Relative dates from the current date
+ (NSDate *)chx_dateTomorrow;
+ (NSDate *)chx_dateYesterday;
+ (NSDate *)chx_dateWithDaysFromNow:(NSUInteger)days;
+ (NSDate *)chx_dateWithDaysBeforeNow:(NSUInteger)days;
+ (NSDate *)chx_dateWithHoursFormNow:(NSUInteger)dHours;
+ (NSDate *)chx_dateWithHoursBeforeNow:(NSUInteger)dHours;
+ (NSDate *)chx_dateWithMinutesFromNow:(NSUInteger)dMinutes;
+ (NSDate *)chx_dateWithMinutesBeforeNow:(NSUInteger)dMinutes;

// Comparing dates
- (BOOL)chx_isEqualToDateIgnoringTime:(NSDate *)date;
- (BOOL)chx_isToday;
- (BOOL)chx_isTomorrow;
- (BOOL)chx_isYesterday;
- (BOOL)chx_isSameWeekAsDate:(NSDate *)date;
- (BOOL)chx_isThisWeek;
- (BOOL)chx_isNextWeek;
- (BOOL)chx_isLastWeek;
- (BOOL)chx_isSameMonthAsDate:(NSDate *)date;
- (BOOL)chx_isThisMonth;
- (BOOL)chx_isSameYearAsDate:(NSDate *)date;
- (BOOL)chx_isThisYear;
- (BOOL)chx_isNextYear;
- (BOOL)chx_isLastYear;
- (BOOL)chx_isEarlierThanDate:(NSDate *)date;
- (BOOL)chx_isLaterThanDate:(NSDate *)date;

// Date roles
- (BOOL)chx_isTypicallyWorkday;
- (BOOL)chx_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)chx_dateByAddingDays:(NSInteger)days;
- (NSDate *)chx_dateBySubtractingDays:(NSInteger)days;
- (NSDate *)chx_dateByAddingHours:(NSInteger)hours;
- (NSDate *)chx_dateBySubtractingHours:(NSInteger)hours;
- (NSDate *)chx_dateByAddingMinutes:(NSInteger)minutes;
- (NSDate *)chx_dateBySubtractingMinutes:(NSInteger)minutes;
- (NSDate *)chx_dateAtStartOfDay;

// Retrieving intervals
- (NSUInteger)chx_minutesAfterDate:(NSDate *)date;
- (NSUInteger)chx_minutesBeforeDate:(NSDate *)date;
- (NSUInteger)chx_hoursAfterDate:(NSDate *)date;
- (NSUInteger)chx_hoursBeforeDate:(NSDate *)date;
- (NSUInteger)chx_daysAfterDate:(NSDate *)date;
- (NSUInteger)chx_daysBeforeDate:(NSDate *)date;

// Decomposing dates
- (NSUInteger)chx_nearestHour;
- (NSUInteger)chx_hour;
- (NSUInteger)chx_minute;
- (NSUInteger)chx_seconds;
- (NSUInteger)chx_day;
- (NSUInteger)chx_month;
- (NSUInteger)chx_week;
- (NSUInteger)chx_weekday;
- (NSUInteger)chx_nthWeekday;
- (NSUInteger)chx_year;

// Format
- (NSString *)chx_stringWithFormat:(NSString *)format;

+ (NSString *)chx_currentTimeStamp;

@end
