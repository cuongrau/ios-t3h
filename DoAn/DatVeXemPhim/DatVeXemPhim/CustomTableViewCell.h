//
//  CustomTableViewCell.h
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImagaView;
@property (strong, nonatomic) IBOutlet UILabel *tenPhimLabel;
@property (strong, nonatomic) IBOutlet UILabel *diemDgLabel;

@end
