//
//  CHXArrayDataSource.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
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
#import <UIKit/UIKit.h>

#pragma mark -

@interface CHXArrayDataSourceSectionItem : NSObject

/// 新建 CHXArrayDataSourceSectionItem 实例对象
- (instancetype)initWithContent:(NSArray *)content;

/// 追加一组数据
- (void)addItemsFromArray:(NSArray *)content;

/// 获取当前的数据内容
- (NSArray *)currentContent;

/// 插入一条数据
- (void)insertRowWithItem:(id)item atIndex:(NSInteger)index;

/// 移除一条数据
- (id)removeItemForRowAtIndex:(NSInteger)index;

@end

#pragma mark -

@interface CHXArrayDataSourceTableViewSectionItem : CHXArrayDataSourceSectionItem

/// 新建 CHXArrayDataSourceTableViewSectionItem 实例对象
/// - contentCell 数据集合
/// - titleForHeader Section header
/// - titleForFooter Section footer
- (instancetype)initWithContent:(NSArray *)content titleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter;

/// 新建 CHXArrayDataSourceTableViewSectionItem 实例对象
/// - content        Cell 数据集合
/// - titleForHeader Section header
/// - titleForFooter Section footer
/// - indexTitle     Section index
- (instancetype)initWithContent:(NSArray *)content titleForHeader:(NSString *)titleForHeader titleForFooter:(NSString *)titleForFooter indexTitle:(NSString *)indexTitle;

/// 新建 section 数据源的时候带上 header 和 footer 的数据
/// 结合 `UITableViewDelegate` 使用
- (instancetype)initWithContent:(NSArray *)content sectionHeaderData:(id)sectionHeaderData sectionFooterData:(id)sectionFooterData;

@end

#pragma mark -

@interface CHXArrayDataSourceCollecionViewSectionItem : CHXArrayDataSourceSectionItem

/// CHXArrayDataSourceCollecionViewSectionItem 实例对象
/// - content                       Cell 数据集合
/// - supplementaryElementForHeader 头部数据
/// - supplementaryElementForFooter 尾部数据
- (instancetype)initWithContent:(NSArray *)content supplementaryElementForHeader:(id)supplementaryElementForHeader supplementaryElementForFooter:(id)supplementaryElementForFooter;

@end

#pragma mark -

/// 配置 Cell 数据
typedef void (^CellConfigureBlock)(id cell, id item);
/// 获取 Cell 重用标识
typedef NSString *(^CellReuseIdentifierForRowAtIndexPath)(NSIndexPath *indexPath);
/// 数据源回调
typedef NSArray *(^DataArrayBlock)(void);

/// 是否允许编辑(删除或者添加)某一行 Cell
typedef BOOL (^CanEditRowAtIndexPath)(NSIndexPath *indexPath);
/// 提交编辑的某一行 Cell，在这里面进行远程数据操作
typedef void (^CommitEditingForRowAtIndexPath)(UITableViewCellEditingStyle editingStyle, id item);
/// 当前添加的 Cell 的位置
typedef void (^CurrentInsertRowAtIndexPath)(NSIndexPath *indexPath);

/// 是否允许对 Cell 进行交换位置
typedef BOOL (^CanMoveRowAtIndexPath)(NSIndexPath *indexPath);

/// 配置 Collection view 头部或者尾部视图的数据
typedef void (^ConfigureSupplementaryElementBlock)(UICollectionReusableView *view, id item);
/// 获取 Collection view 头部或者尾部视图的重新标识
typedef NSString *(^CollectionSupplementaryElementReuseIdentifierForIndexPath)(NSIndexPath *indexPath, NSString *kind);

@interface CHXArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

/// 新建 CHXArrayDataSource 实例对象
/// - dataArray 数据数组，元素必须为 CHXArrayDataSourceSectionItem 或者其子类对象
/// - cellReuseIdentifierForIndexPath Cell 重用标识
/// - configureBlock                  Cell 界面配置
- (instancetype)initWithDataArray:(NSMutableArray *)dataArray
       cellReuseIdentifierForIndexPath:(CellReuseIdentifierForRowAtIndexPath)cellReuseIdentifierForIndexPath
                    cellConfigureBlock:(CellConfigureBlock)configureBlock;

///  新建 CHXArrayDataSource 实例对象
/// - dataArrayBlock                  数据数组，元素必须为 CHXArrayDataSourceSectionItem 或者其子类对象
/// - cellReuseIdentifierForIndexPath Cell 重用标识
/// - configureBlock                  Cell 界面配置
- (instancetype)initWithDataArrayBlock:(DataArrayBlock)dataArrayBlock
       cellReuseIdentifierForIndexPath:(CellReuseIdentifierForRowAtIndexPath)cellReuseIdentifierForIndexPath
                    cellConfigureBlock:(CellConfigureBlock)configureBlock;

/// 根据界面坐标获取 cell 数据
- (id)itemForRowAtIndexPath:(NSIndexPath *)indexPath;
/// 根据界面坐标获取 section 数据
- (NSArray *)itemsInSection:(NSInteger)section;
/// 根据界面坐标获取头部数据
- (id)itemForHeaderInSection:(NSInteger)section;
/// 根据界面坐标获取尾部数据
- (id)itemForFooterInSection:(NSInteger)section;
/// 给指定 section 添加数据
- (void)addRowsWithItems:(NSArray *)items inSection:(NSInteger)section;
/// 指定位置插入数据
- (void)insertRowWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath;
/// 移除指定坐标的数据
- (id)removeItemForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 以下 Block 为可选配置

@property (nonatomic, copy) CanEditRowAtIndexPath canEditRowAtIndexPath;
@property (nonatomic, copy) CommitEditingForRowAtIndexPath commitEditingForRowAtIndexPath;
@property (nonatomic, copy) CurrentInsertRowAtIndexPath currentInsertRowAtIndexPath;

@property (nonatomic, copy) CanMoveRowAtIndexPath canMoveRowAtIndexPath;

@property (nonatomic, copy) CollectionSupplementaryElementReuseIdentifierForIndexPath collectionSupplementaryElementReuseIdentifierForIndexPath;
@property (nonatomic, copy) ConfigureSupplementaryElementBlock configureSupplementaryElementBlock;

@end


