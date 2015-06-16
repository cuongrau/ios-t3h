//
//  ChiTietPhimViewController.m
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import "ChiTietPhimViewController.h"
#import "ChonGheViewController.h"

@interface ChiTietPhimViewController ()

@end

@implementation ChiTietPhimViewController

@synthesize phim, imageName, phimImageView, tenPhimLabel, daoDienLabel, thoiLuongLabel, ngayChieuLabel, noiDungTomTatTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Đặt tiêu đề cho trang
    self.title = @"Chi tiết phim";
    // Đặt thuộc tính cho textview
    [noiDungTomTatTextView setScrollEnabled:YES];
    noiDungTomTatTextView.editable = NO;
    // Cập nhật thông tin image view
    phimImageView.frame = CGRectMake(self.phimImageView.frame.origin.x, self.phimImageView.frame.origin.y, self.phimImageView.frame.size.width, self.phimImageView.frame.size.height);
    // Cập nhật thông tin phim
    phimImageView.image = [UIImage imageNamed:imageName];
    tenPhimLabel.text = phim.tenPhim;
    daoDienLabel.text = phim.daoDien;
    thoiLuongLabel.text = [NSString stringWithFormat:@"%.2d phút", phim.thoiLuong];
    ngayChieuLabel.text = phim.ngayKhoiChieu;
    noiDungTomTatTextView.text = phim.noiDungTomTat;
}

- (void)setPhim:(Phim *)newPhim withImage:(NSString *)image {
    phim = newPhim;
    imageName = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)datVeButtonDidTouch:(UIButton *)sender {
    ChonGheViewController *chonGheView = [self.storyboard instantiateViewControllerWithIdentifier:@"chonGheViewController"];
    chonGheView.phim = phim;
    // Push detail view
    [self.navigationController pushViewController:chonGheView animated:YES];
}

@end
