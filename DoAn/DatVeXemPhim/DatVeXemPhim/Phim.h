//
//  Phim.h
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Phim : NSObject

@property (nonatomic, assign) int soThuTu;
@property (nonatomic, copy) NSString *tenPhim;
@property (nonatomic, copy) NSString *daoDien;
@property (nonatomic, assign) int thoiLuong;
@property (nonatomic, copy) NSString *theLoai;
@property (nonatomic, copy) NSString *ngayKhoiChieu;
@property (nonatomic, copy) NSString *noiDungTomTat;
@property (nonatomic, assign) float diemDanhGia;
@property (nonatomic, assign) int giaVeThuong;
@property (nonatomic, assign) int giaVeVIP;
@property (nonatomic, copy) NSString *soGheDaDat;
@property (nonatomic, assign) int mucPhim;

+ (NSMutableArray *)layDsPhim:(sqlite3 *)db withPath:(NSString *)dataPath;
+ (BOOL)updateSoGheDaDat:(NSString *)soGheDaDat withSoThuTu:(NSInteger)soThuTu;

@end
