//
//  ChonGheViewController.m
//  DatVeXemPhim
//
//  Created by Cuong on 5/22/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import "ChonGheViewController.h"

@interface ChonGheViewController ()

@end

@implementation ChonGheViewController

UIBarButtonItem *rightButton;

@synthesize phim, chonGheCollectionView, danhSachGheDaDat;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Đặt title cho view
    self.title = @"Chọn ghế";
    
    // Cài đặt cho Left button
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *backBtnImage = [UIImage imageNamed:@"back.png"];
//    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backButtonDidTouch:) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.frame = CGRectMake(0, 0, 24, 24);
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backButton;
    
    // Cài đặt cho Right button
    rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Xong" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonDidTouch:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    // Disable chức năng nút 'Xong' nếu chưa chọn ghế
    rightButton.enabled = NO;

    // Tạo danh sách ghế đã đặt
    [self taoDsGheDaDat];
    NSLog(@"Ds ghế đã đặt: %@", danhSachGheDaDat);
    // Chọn nhiều phần tử trên collection view
    self.chonGheCollectionView.allowsMultipleSelection = YES;
}

// Cài đặt layout cho collection view
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(22, 22);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 72;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"Cell";
    UICollectionViewCell *cell = [chonGheCollectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    // Đặt trạng thái các ghế là Ghế thường
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gheThuong.png"]];
    if (indexPath.row > 26 && indexPath.row < 54) { // 3 dãy giữa: ghế VIP
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gheVIP.png"]];
    }
    if ([danhSachGheDaDat containsObject:[NSString stringWithFormat:@"%d", indexPath.row]]) {   // ghế đã đặt
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gheDaDat.png"]];
    }
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gheDangChon.png"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Chọn: %d", indexPath.row);
    // Enable chức năng nút 'Xong'
    rightButton.enabled = YES;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *selectedItemIndexPaths = [chonGheCollectionView indexPathsForSelectedItems];
    // Disable chức năng nút 'Xong' nếu bỏ chọn hết số ghế
    if (selectedItemIndexPaths.count == 0) {
        rightButton.enabled = NO;
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Không cho chọn những vé đã đặt
    if ([danhSachGheDaDat containsObject:[NSString stringWithFormat:@"%d", indexPath.row]]) {
        return NO;
    }
    return YES;
}

//Handle the Back Button Event
- (void)backButtonDidTouch:(id)sender {
    // do your custom handler code here
    [self.navigationController popViewControllerAnimated:YES];
}

//Handle the Done Button Event
- (void)doneButtonDidTouch:(id)sender {
    // Tạo 2 danh sách ghế thường và ghế Vip đã đặt
    NSMutableArray *gheVIPDaDat = [[NSMutableArray alloc] init];
    NSMutableArray *gheThuongDaDat = [[NSMutableArray alloc] init];
    // Lấy các item đã chọn trên collection view
    NSArray *selectedItemIndexPaths = [chonGheCollectionView indexPathsForSelectedItems];
    // Lấy các dòng tương ứng
    for (NSIndexPath *indexPath in selectedItemIndexPaths) {
        if (indexPath.row > 26 && indexPath.row < 54) // Ghế Vip
            [gheVIPDaDat addObject:[NSString stringWithFormat:@"%d", indexPath.row]];
        else // Ghế thường
            [gheThuongDaDat addObject:[NSString stringWithFormat:@"%d", indexPath.row]];
    }
    // Thông báo xác nhận đặt vé
    int soGheVip = gheVIPDaDat.count;
    int soGheThuong = gheThuongDaDat.count;
    long thanhTien = soGheVip * phim.giaVeVIP + soGheThuong * phim.giaVeThuong;
    NSString *msg = @"";
    if (soGheThuong > 0 || soGheVip > 0) {
        msg = [msg stringByAppendingString:@"Bạn đã đặt vé bao gồm:"];
        if (soGheThuong > 0) {
            msg = [msg stringByAppendingFormat:@"\n%d vé thường giá %d/vé", soGheThuong, phim.giaVeThuong];
        }
        if (soGheVip > 0) {
            msg = [msg stringByAppendingFormat:@"\n%d vé VIP giá %d/vé", soGheVip, phim.giaVeVIP];
        }
        msg = [msg stringByAppendingFormat:@"\nTổng tiền: %ld", thanhTien];

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Xác nhận" message:msg delegate:self cancelButtonTitle:@"Mua" otherButtonTitles:@"Huỷ", nil];
        [alert show];
    }
    NSLog(@"Đặt ghế thường: %@", gheThuongDaDat);
    NSLog(@"Đặt ghế VIP: %@", gheVIPDaDat);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"Mua"]) {
        // Tạo lại danh sách ghế đã đặt để cập nhật
        NSArray *selectedItemIndexPaths = [chonGheCollectionView indexPathsForSelectedItems];
        // Lấy số ghế đã đặt ban đầu
        NSString *gheDaDat = [[NSString alloc] initWithString:phim.soGheDaDat];
        for (NSIndexPath *indexPath in selectedItemIndexPaths) {
            // Tạo định dạng tương ứng trong csdl
            gheDaDat = [gheDaDat stringByAppendingFormat:@"-%d", indexPath.row];
        }
        NSLog(@"Tổng số ghế đặt: %@", gheDaDat);
        // Lấy đường dẫn database
        [self getDataPath];
        // Cập nhật số ghế đã đặt xuống csdl
        if ([Phim updateSoGheDaDat:gheDaDat withSoThuTu:phim.soThuTu] == true) {
            // Gán lại số ghế đã đặt
            phim.soGheDaDat = gheDaDat;
            // Tạo lại danh sách ghế đã đặt
            [self taoDsGheDaDat];
            NSLog(@"update số ghế đặt thành công");
        } else {
            NSLog(@"update số ghế đặt thất bại");
        }
    } else {
        // Bỏ chọn các item
//        NSArray *selectedItemIndexPaths = [chonGheCollectionView indexPathsForSelectedItems];
//        for (NSIndexPath *indexPath in selectedItemIndexPaths) {
//            [chonGheCollectionView deselectItemAtIndexPath:indexPath animated:YES];
//        }
    }
    [chonGheCollectionView reloadData];
    // Disable nút 'Xong'
    rightButton.enabled = NO;
}

- (void)taoDsGheDaDat {
    danhSachGheDaDat = [phim.soGheDaDat componentsSeparatedByString:@"-"];
}

- (void)getDataPath {
    // Lấy đường dẫn thư mục Documents
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // Tạo đường dẫn dataPath từ thư mục Documents
    dataPath = [[NSString alloc] initWithString:[documentsDir stringByAppendingPathComponent:@"DSPhimDB.sqlite"]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Chưa có DemoDB.sqlite trong thư mục Documents
    if ([fileManager fileExistsAtPath:dataPath] == NO) {
        // Copy file DemoDB.sqlite từ Bundle vào thư mục Documents
        NSString *pathFromBundle = [[NSBundle mainBundle] pathForResource:@"DSPhimDB" ofType:@"sqlite"];
        [fileManager copyItemAtPath:pathFromBundle toPath:dataPath error:nil];
    }
    NSLog(@"Data path: %@", dataPath);
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

@end
