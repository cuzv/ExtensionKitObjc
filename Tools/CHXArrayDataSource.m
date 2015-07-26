//
//  CHXArrayDataSource.m
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

#import "CHXArrayDataSource.h"

#pragma mark - CHXArrayDataSourceSectionItem

@interface CHXArrayDataSourceSectionItem ()
@property (nonatomic, strong) NSArray *content;
@end

@implementation CHXArrayDataSourceSectionItem

- (instancetype)initWithContent:(NSArray *)content {
    if (self = [super init]) {
        _content = content;
    }
    
    return self;
}

- (void)addItemsFromArray:(NSArray *)content {
    NSMutableArray *currentContent = [self.content mutableCopy];
    [currentContent addObjectsFromArray:content];
    self.content = [[NSArray alloc] initWithArray:currentContent];
}

- (NSArray *)currentContent {
    return self.content;
}

- (void)insertRowWithItem:(id)item atIndex:(NSInteger)index {
    NSMutableArray *currentContent = [self.content mutableCopy];
    if (currentContent.count < index) {
        NSLog(@"添加数据失败，数组角标越界");
        return;
    }
    [currentContent insertObject:item atIndex:index];
    self.content = [[NSArray alloc] initWithArray:currentContent];
}

- (id)removeItemForRowAtIndex:(NSInteger)index {
    NSMutableArray *currentContent = [self.content mutableCopy];
    if (currentContent.count < index) {
        NSLog(@"移除数据失败，数组角标越界");
        return nil;
    }
    
    id result = [currentContent objectAtIndex:index];
    [currentContent removeObject:result];
    self.content = [[NSArray alloc] initWithArray:currentContent];

    return result;
}

@end

#pragma mark - CHXArrayDataSourceTableViewSectionItem

@interface CHXArrayDataSourceTableViewSectionItem ()
@property (nonatomic, copy) NSString *titleForHeader;
@property (nonatomic, copy) NSString *titleForFooter;
@property (nonatomic, copy) NSString *indexTitle;
@property (nonatomic, strong) id sectionHeaderData;
@property (nonatomic, strong) id sectionFooterData;
@end

@implementation CHXArrayDataSourceTableViewSectionItem

- (instancetype)initWithContent:(NSArray *)content
                 titleForHeader:(NSString *)titleForHeader
                 titleForFooter:(NSString *)titleForFooter {
    return [self initWithContent:content titleForHeader:titleForHeader titleForFooter:titleForFooter indexTitle:nil];
}

- (instancetype)initWithContent:(NSArray *)content
                 titleForHeader:(NSString *)titleForHeader
                 titleForFooter:(NSString *)titleForFooter
                     indexTitle:(NSString *)indexTitle {
    if (self = [super initWithContent:content]) {
        _titleForHeader = titleForHeader;
        _titleForFooter = titleForFooter;
        _indexTitle = indexTitle;
    }
    
    return self;
}

- (instancetype)initWithContent:(NSArray *)content sectionHeaderData:(id)sectionHeaderData sectionFooterData:(id)sectionFooterData {
    self = [super initWithContent:content];
    if (!self) {
        return nil;
    }
    
    _sectionHeaderData = sectionHeaderData;
    _sectionFooterData = sectionFooterData;
    
    return self;
}

@end

#pragma mark - CHXArrayDataSourceCollecionViewSectionItem

@interface CHXArrayDataSourceCollecionViewSectionItem ()
@property (nonatomic, strong) id supplementaryElementForHeader;
@property (nonatomic, strong) id supplementaryElementForFooter;
@end

@implementation CHXArrayDataSourceCollecionViewSectionItem

- (instancetype)initWithContent:(NSArray *)content
  supplementaryElementForHeader:(id)supplementaryElementForHeader
  supplementaryElementForFooter:(id)supplementaryElementForFooter {
    if (self = [super initWithContent:content]) {
        _supplementaryElementForHeader = supplementaryElementForHeader;
        _supplementaryElementForFooter = supplementaryElementForFooter;
    }
    
    return self;
}

@end

#pragma mark - CHXArrayDataSource

@interface CHXArrayDataSource ()
@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;
@property (nonatomic, copy) CellReuseIdentifierForRowAtIndexPath cellReuseIdentifierForIndexPath;
// KVO didn't support mutable array add/remove notificaion
@property (nonatomic, copy) DataArrayBlock dataArrayBlock;
@end

NSString *const kNoneCollectionSectionHeaderIdentifier = @"NoneUICollectionElementKindSectionHeader";
NSString *const kNoneCollectionSectionFooterIdentifier = @"NoneUICollectionElementKindSectionFooter";

@implementation CHXArrayDataSource

- (instancetype)init {
    NSAssert(NO, @"Please use designed initialized construct mthod !");
    return nil;
}

- (instancetype)initWithDataArray:(NSMutableArray *)dataArray
       cellReuseIdentifierForIndexPath:(CellReuseIdentifierForRowAtIndexPath)cellReuseIdentifierForIndexPath
                    cellConfigureBlock:(CellConfigureBlock)configureBlock {
    if (self = [super init]) {
        self.sections = dataArray;
        self.cellReuseIdentifierForIndexPath = cellReuseIdentifierForIndexPath;
        self.configureCellBlock = configureBlock;
    }
    
    return self;
}

- (instancetype)initWithDataArrayBlock:(DataArrayBlock)dataArrayBlock
  cellReuseIdentifierForIndexPath:(CellReuseIdentifierForRowAtIndexPath)cellReuseIdentifierForIndexPath
               cellConfigureBlock:(CellConfigureBlock)configureBlock {
    if (self = [super init]) {
        self.dataArrayBlock = dataArrayBlock;
        self.cellReuseIdentifierForIndexPath = cellReuseIdentifierForIndexPath;
        self.configureCellBlock = configureBlock;
    }
    
    return self;
}

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [self.dataArrayBlock() mutableCopy];
    }
    
    return _sections;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self pr_numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self pr_numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.cellReuseIdentifierForIndexPath(indexPath);
    NSParameterAssert(identifier);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];;
    id item = [self itemForRowAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id sectionItem = self.sections[section];
    
    if ([sectionItem class] != NSClassFromString(@"CHXArrayDataSourceTableViewSectionItem")) {
        return nil;
    }
    
    return [sectionItem titleForHeader];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    id sectionItem = self.sections[section];
    
    if ([sectionItem class] != NSClassFromString(@"CHXArrayDataSourceTableViewSectionItem")) {
        return nil;
    }
    
    return [sectionItem titleForFooter];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if ([self.sections.firstObject class] != NSClassFromString(@"CHXArrayDataSourceTableViewSectionItem")) {
        return nil;
    }

    NSArray *titles = [self.sections valueForKey:@"indexTitle"];
    
    /// If titles contains [NSNull null] will crash
    __block BOOL valid = YES;
    id nilObject = [NSNull null];
    [titles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqual:nilObject]) {
            valid = NO;
            *stop = YES;
        }
    }];
    if (!valid) {
        return nil;
    }
    
    return titles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [[self.sections valueForKey:@"indexTitle"] indexOfObject:title];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.canEditRowAtIndexPath) {
        return NO;
    }
    
    return self.canEditRowAtIndexPath(indexPath);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.commitEditingForRowAtIndexPath) {
        // UI Editing
        id editingItem = [self itemForRowAtIndexPath:indexPath];
        id sectionItem = self.sections[indexPath.section];
        NSMutableArray *content = [[sectionItem content] mutableCopy];
        
        if (UITableViewCellEditingStyleDelete == editingStyle) {
            [content removeObjectAtIndex:indexPath.row];
            [sectionItem setContent:[NSArray arrayWithArray:content]];
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (UITableViewCellEditingStyleInsert == editingStyle) {
            // Duplicate last content item, in case reload data error, should not use it.
            [content insertObject:content.lastObject atIndex:indexPath.row];
            [sectionItem setContent:[NSArray arrayWithArray:content]];
            
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            if (self.currentInsertRowAtIndexPath) {
                self.currentInsertRowAtIndexPath(newIndexPath);
            }
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
        // Remote Editing
        self.commitEditingForRowAtIndexPath(editingStyle, editingItem);
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL can = NO;
    if (self.canMoveRowAtIndexPath) {
        can = self.canMoveRowAtIndexPath(indexPath);
    }
    return can;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    CHXArrayDataSourceSectionItem *sourceItem = self.sections[sourceIndexPath.section];
    NSMutableArray *sourceContent = [sourceItem.content mutableCopy];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [sourceContent exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    } else {
        id temp = [sourceContent objectAtIndex:sourceIndexPath.row];
        [sourceContent removeObject:temp];
        
        CHXArrayDataSourceSectionItem *destinationItem = self.sections[destinationIndexPath.section];
        NSMutableArray *destinationContent = [destinationItem.content mutableCopy];
        [destinationContent insertObject:temp atIndex:destinationIndexPath.row];
        
        destinationItem.content = [NSArray arrayWithArray:destinationContent];
    }
    
    sourceItem.content = [NSArray arrayWithArray:sourceContent];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self pr_numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self pr_numberOfRowsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.cellReuseIdentifierForIndexPath(indexPath);
    NSParameterAssert(identifier);
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    id item = [self itemForRowAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.collectionSupplementaryElementReuseIdentifierForIndexPath) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kNoneCollectionSectionHeaderIdentifier];
            [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kNoneCollectionSectionFooterIdentifier];
        });
        
        UICollectionReusableView *collectionReusableView = nil;
        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
            collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNoneCollectionSectionHeaderIdentifier forIndexPath:indexPath];
        } else {
            collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kNoneCollectionSectionFooterIdentifier forIndexPath:indexPath];
        }
        return collectionReusableView;
    }
    
    NSString *identifier = self.collectionSupplementaryElementReuseIdentifierForIndexPath(indexPath, kind);
    UICollectionReusableView *collectionReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    id item = [self pr_supplementaryElementItemAtIndexPath:indexPath ofKind:kind];
    
    if (self.configureSupplementaryElementBlock) {
        self.configureSupplementaryElementBlock(collectionReusableView, item);
    }
    
    return collectionReusableView;
}

#pragma mark - Private

- (NSInteger)pr_numberOfSections {
    return self.sections.count;
}

- (id)pr_supplementaryElementItemAtIndexPath:(NSIndexPath *)indexPath ofKind:(NSString *)kind {
    id sectionItem = self.sections[indexPath.section];
    
    id returnValue = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        returnValue = [sectionItem supplementaryElementForHeader];
    } else {
        returnValue = [sectionItem supplementaryElementForFooter];
    }
    
    return returnValue;
}

- (NSInteger)pr_numberOfRowsInSection:(NSInteger)section {
    CHXArrayDataSourceSectionItem *sectionItem = self.sections[section];
    return [[sectionItem content] count];
}

#pragma mark - Public

- (id)itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHXArrayDataSourceSectionItem *sectionItem = self.sections[indexPath.section];
    return [sectionItem content][indexPath.row];
}

- (NSArray *)itemsInSection:(NSInteger)section {
    return [self.sections[section] content];
}

- (id)itemForHeaderInSection:(NSInteger)section {
    CHXArrayDataSourceSectionItem *sectionItem = self.sections[section];
    if (![sectionItem isKindOfClass:[CHXArrayDataSourceTableViewSectionItem class]]) {
        return nil;
    }
    
    CHXArrayDataSourceTableViewSectionItem *itme = (CHXArrayDataSourceTableViewSectionItem *)sectionItem;
    return itme.sectionHeaderData;
}

- (id)itemForFooterInSection:(NSInteger)section {
    CHXArrayDataSourceSectionItem *sectionItem = self.sections[section];
    if (![sectionItem isKindOfClass:[CHXArrayDataSourceTableViewSectionItem class]]) {
        return nil;
    }
    
    CHXArrayDataSourceTableViewSectionItem *itme = (CHXArrayDataSourceTableViewSectionItem *)sectionItem;
    return itme.sectionFooterData;
}

- (void)addRowsWithItems:(NSArray *)items inSection:(NSInteger)section {
    NSMutableArray *sections = self.sections;
    if (sections.count < section) {
        return;
    }
    
    CHXArrayDataSourceSectionItem *sectionItem = sections[section];
    [sectionItem addItemsFromArray:items];
}

- (void)insertRowWithItem:(id)item atIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *sections = self.sections;
    if (sections.count < indexPath.section) {
        NSLog(@"添加数据失败，数组角标越界");        
        return;
    }
    
    CHXArrayDataSourceSectionItem *sectionItem = sections[indexPath.section];
    [sectionItem insertRowWithItem:item atIndex:indexPath.row];
}

- (id)removeItemForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *sections = self.sections;
    if (sections.count < indexPath.section) {
        NSLog(@"移除数据失败，数组角标越界");
        return nil;
    }
    
    CHXArrayDataSourceSectionItem *sectionItem = sections[indexPath.section];
    
    return [sectionItem removeItemForRowAtIndex:indexPath.row];
}


@end

