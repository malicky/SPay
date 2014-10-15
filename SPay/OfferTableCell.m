//
//  OfferTableCell.m
//  SPay
//
//  Created by Malick Youla on 2014-10-15.
//  Copyright (c) 2014 Malick Youla. All rights reserved.
//

#import "OfferTableCell.h"
#import "UIImageView+Network.h"

@implementation OfferTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSString *cachingKey = self.thumbnailURLString;
    [self.thumbnailImageView loadImageFromURL:[NSURL URLWithString:cachingKey]
           placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] cachingKey:cachingKey];
}
@end
