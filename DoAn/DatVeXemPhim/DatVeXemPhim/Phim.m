//
//  Phim.m
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import "Phim.h"

@implementation Phim

sqlite3 *db;
NSString *dataPath;

@synthesize soThuTu, tenPhim, daoDien, thoiLuong, theLoai, ngayKhoiChieu, noiDungTomTat, diemDanhGia, giaVeThuong, giaVeVIP, soGheDaDat, mucPhim;

- (id)initWithId:(int)pId andTenPhim:(NSString *)tenphim andDaoDien:(NSString *)daodien andThoiLuong:(NSInteger)thoiluong andTheLoai:(NSString *)theloai andNgayKhoiChieu:(NSString *)ngaykhoichieu andNoiDungTomTat:(NSString *)noidungtomtat andDiemDanhGia:(float)diemdanhgia andGiaVeThuong:(NSInteger)giavethuong andGiaVeVIP:(NSInteger)giaveVip andSoGheDaDat:(NSString *)soghedadat andMucPhim:(NSInteger)mucphim {

    soThuTu = pId;
    tenPhim = tenphim;
    daoDien = daodien;
    thoiLuong = thoiluong;
    theLoai = theloai;
    ngayKhoiChieu = ngaykhoichieu;
    noiDungTomTat = noidungtomtat;
    diemDanhGia = diemdanhgia;
    giaVeThuong = giavethuong;
    giaVeVIP = giaveVip;
    soGheDaDat = soghedadat;
    mucPhim = mucphim;
    // Trả về đối tượng Phim
    return self;
}

+ (NSString *)getDataPath {
    // Lấy đường dẫn thư mục Documents
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // Tạo đường dẫn dataPath từ thư mục Documents
    return [[NSString alloc] initWithString:[documentsDir stringByAppendingPathComponent:@"DSPhimDB.sqlite"]];
}

+ (NSMutableArray *)layDsPhim:(sqlite3 *)db withPath:(NSString *)dataPath {
    NSMutableArray *contents = [[NSMutableArray alloc] init];
    
    const char *dbPath = [dataPath UTF8String];
    if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
        sqlite3_stmt *statement;
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM DSPhim"];
        const char *query_stm = [query UTF8String];
        if (sqlite3_prepare_v2(db, query_stm, -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int soThuTu = (NSInteger) sqlite3_column_int(statement, 0);
                char *tenPhim = (char *) sqlite3_column_text(statement, 1);
                char *daoDien = (char *) sqlite3_column_text(statement, 2);
                int thoiLuong = (NSInteger) sqlite3_column_int(statement, 3);
                char *theLoai = (char *) sqlite3_column_text(statement, 4);
                char *ngayKhoiChieu = (char *) sqlite3_column_text(statement, 5);
                char *noiDungTomTat = (char *) sqlite3_column_text(statement, 6);
                float diemDanhGia = (float) sqlite3_column_double(statement, 7);
                int giaVeThuong = (NSInteger) sqlite3_column_int(statement, 8);
                int giaVeVIP = (NSInteger) sqlite3_column_int(statement, 9);
                char *soGheDaDat = (char *) sqlite3_column_text(statement, 10);
                int mucPhim = (NSInteger) sqlite3_column_int(statement, 11);
                
                NSString *tenPhimStr = (tenPhim == NULL)?nil:[[NSString alloc] initWithUTF8String:tenPhim];
                NSString *daoDienStr = (daoDien == NULL)?nil:[[NSString alloc] initWithUTF8String:daoDien];
                NSString *theLoaiStr = (theLoai == NULL)?nil:[[NSString alloc] initWithUTF8String:theLoai];
                NSString *ngayKhoiChieuStr = (ngayKhoiChieu == NULL)?nil:[[NSString alloc] initWithUTF8String:ngayKhoiChieu];
                NSString *noiDungTomTatStr = (noiDungTomTat == NULL)?nil:[[NSString alloc] initWithUTF8String:noiDungTomTat];
                NSString *soGheDaDatStr = (soGheDaDat == NULL)?nil:[[NSString alloc] initWithUTF8String:soGheDaDat];
                
                Phim *phim = [[Phim alloc] initWithId:soThuTu andTenPhim:tenPhimStr andDaoDien:daoDienStr andThoiLuong:thoiLuong andTheLoai:theLoaiStr andNgayKhoiChieu:ngayKhoiChieuStr andNoiDungTomTat:noiDungTomTatStr andDiemDanhGia:diemDanhGia andGiaVeThuong:giaVeThuong andGiaVeVIP:giaVeVIP andSoGheDaDat:soGheDaDatStr andMucPhim:mucPhim];
                
                [contents addObject:phim];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return contents;
}

+ (BOOL)insertUserWithName:(NSString *)name andEmail:(NSString *)email andAddress:(NSString *)address {
    
    dataPath = [self getDataPath];
    
    const char *dbPath = [dataPath UTF8String];
    if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
        sqlite3_stmt *statement;
        NSString *query = [NSString stringWithFormat:@"INSERT INTO demo_User(NAME, EMAIL, ADDRESS) values(?, ?, ?)"];
        const char *query_stm = [query UTF8String];
        if (sqlite3_prepare_v2(db, query_stm, -1, &statement, nil) == SQLITE_OK) {
            
            sqlite3_bind_text(statement, 1, [name UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 2, [email UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [address UTF8String], -1, NULL);
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                return true;
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return false;
}

+ (BOOL)updateSoGheDaDat:(NSString *)soGheDaDat withSoThuTu:(NSInteger)soThuTu {
    
    dataPath = [self getDataPath];
    
    const char *dbPath = [dataPath UTF8String];
    if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
        sqlite3_stmt *statement;
        NSString *query = [NSString stringWithFormat:@"UPDATE DSPhim SET soGheDaDat = ? WHERE soThuTu = ?"];
        const char *query_stm = [query UTF8String];
        if (sqlite3_prepare_v2(db, query_stm, -1, &statement, nil) == SQLITE_OK) {
            
            sqlite3_bind_text(statement, 1, [soGheDaDat UTF8String], -1, NULL);
            sqlite3_bind_int(statement, 2, soThuTu);
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                return true;
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return false;
}

+ (BOOL)deleteUserWithId:(NSInteger)userId {
    
    dataPath = [self getDataPath];
    
    const char *dbPath = [dataPath UTF8String];
    if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
        sqlite3_stmt *statement;
        NSString *query = [NSString stringWithFormat:@"DELETE FROM demo_User WHERE ID = ?"];
        const char *query_stm = [query UTF8String];
        if (sqlite3_prepare_v2(db, query_stm, -1, &statement, nil) == SQLITE_OK) {
            
            sqlite3_bind_int(statement, 1, userId);
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                return true;
            }
            
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return false;
}

@end
