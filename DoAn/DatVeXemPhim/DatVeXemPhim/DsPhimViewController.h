//
//  DsPhimViewController.h
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DsPhimViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    sqlite3 *db;
    NSString *dataPath;
}

@property (strong, nonatomic) IBOutlet UITableView *dsPhimTableView;

@property (strong, nonatomic) NSMutableArray *danhSachPhim;
@property (strong, nonatomic) NSMutableArray *phimDangChieu;
@property (strong, nonatomic) NSMutableArray *phimSapChieu;

- (IBAction)chooseDsPhimSegmentDidTouch:(UISegmentedControl *)sender;

@end
