//
//  EKBorderedItemFlowLayout.h
//  WeBusiness
//
//  Created by Haioo Inc on 8/2/17.
//  Copyright © 2017 Haioo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EKBorderedItemFlowLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, assign, readonly) BOOL nearTop;
@property (nonatomic, assign, readonly) BOOL nearLeft;
@end

@interface EKBorderedItemFlowLayout : UICollectionViewFlowLayout
@end


//override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//    super.apply(layoutAttributes)
//    guard let layoutAttributes = layoutAttributes as? BorderedItemFlowLayoutAttributes else {
//        return
//    }
//    if layoutAttributes.nearByTop {
//        contentView.addBorderline(for: .top)
//    } else {
//        contentView.removeBorderline(for: .top)
//    }
//    if layoutAttributes.nearByLeft {
//        contentView.addBorderline(for: .left)
//    } else {
//        contentView.removeBorderline(for: .left)
//    }
//}
