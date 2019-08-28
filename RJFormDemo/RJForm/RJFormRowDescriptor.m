//
//  RJFormRowDescriptor.m
//  RJFormDemo
//
//  Created by TouchWorld on 2019/7/23.
//  Copyright © 2019 RJSoft. All rights reserved.
//

#import "RJFormRowDescriptor.h"
#import "RJFormCellDataUpdate.h"
#import "RJFormDescriptor.h"
#import "RJFormImagePickerItem.h"

@interface RJFormRowDescriptor ()

/********* cell的class *********/
@property (readwrite, nonatomic, strong) Class cellClass;
/********* 重利用id *********/
@property (readwrite, nonatomic, copy) NSString *reuseIdentifier;
/********* 模型 *********/
@property (readwrite, nonatomic, strong) id item;

@end

@implementation RJFormRowDescriptor

#pragma mark - Init Methods

+ (instancetype)rowWithTag:(NSString *)tag cellClass:(Class)cellClass item:(id<RJFormItemValue>)item
{
    return [[self alloc] initWithTag:tag cellClass:cellClass item:item];
}

+ (instancetype)rowWithTag:(NSString *)tag item:(id<RJFormItemValue>)item
{
    if (item == nil)
    {
        return nil;
    }
    
    NSString *itemClassStr = NSStringFromClass([item class]);
    NSDictionary *itemCellClassPairs = [RJFormDescriptor itemCellClassPairs];
    if (itemCellClassPairs[itemClassStr] == nil)
    {
        NSDictionary *userInfo = @{
                                   @"itemClass" : itemClassStr
                                   };
        @throw [NSException exceptionWithName:@"RJFormRowDescripto's rowWithItem: method error" reason:@"cell class not found" userInfo:userInfo];
        return nil;
    }
    
    NSString *cellClassStr = itemCellClassPairs[itemClassStr];
    return [self rowWithTag:tag cellClass:NSClassFromString(cellClassStr) item:item];
}

+ (instancetype)rowWithItem:(id<RJFormItemValue>)item
{
    return [self rowWithTag:nil item:item];
}

- (instancetype)initWithTag:(NSString *)tag cellClass:(Class)cellClass item:(id<RJFormItemValue>)item
{
    if (self = [self init])
    {
        self.tag = tag;
        item.tag = tag;
        self.cellClass = cellClass;
        self.item = item;
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init])
    {
        self.rowHeight = 49.0;
    }
    return self;
}

#pragma mark - Public Methods

- (void)updateCell:(UITableViewCell *)cell
{
    if ([cell respondsToSelector:@selector(updateViewData:tag:)])
    {
        [(id<RJFormCellDataUpdate>)cell updateViewData:self.item tag:self.tag];
        return;
    }
}

- (void)calculateRowHeight
{
    if (!self.item)
    {
        return;
    }
    
    if(![self.item isKindOfClass:[RJFormImagePickerItem class]])
    {
        return;
    }
    
    RJFormImagePickerItem *item = (RJFormImagePickerItem *)self.item;
    
    //重新计算高度
    [item calculateRowHeight];
    
    self.rowHeight = item.rowHeight;
    
}

#pragma mark - Properties Methods

- (NSString *)reuseIdentifier
{
    if (_reuseIdentifier == nil)
    {
        _reuseIdentifier = NSStringFromClass(self.cellClass);
    }
    return _reuseIdentifier;
}
@end
