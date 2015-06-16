//
//  ChiTietPhimViewController.h
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phim.h"

@interface ChiTietPhimViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *phimImageView;
@property (strong, nonatomic) IBOutlet UILabel *tenPhimLabel;
@property (strong, nonatomic) IBOutlet UILabel *daoDienLabel;
@property (strong, nonatomic) IBOutlet UILabel *thoiLuongLabel;
@property (strong, nonatomic) IBOutlet UILabel *ngayChieuLabel;
@property (strong, nonatomic) IBOutlet UITextView *noiDungTomTatTextView;


@property (strong, nonatomic) Phim *phim;
@property (strong, nonatomic) NSString *imageName;


- (void)setPhim:(Phim *)newPhim withImage:(NSString *)image;
- (IBAction)datVeButtonDidTouch:(UIButton *)sender;

@end
