//
//  ChonGheViewController.h
//  DatVeXemPhim
//
//  Created by Cuong on 5/22/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Phim.h"
#import <sqlite3.h>

@interface ChonGheViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    sqlite3 *db;
    NSString *dataPath;
}


@property (strong, nonatomic) IBOutlet UICollectionView *chonGheCollectionView;

@property (strong, nonatomic) Phim *phim;
@property (strong, nonatomic) NSArray *danhSachGheDaDat;

@end
