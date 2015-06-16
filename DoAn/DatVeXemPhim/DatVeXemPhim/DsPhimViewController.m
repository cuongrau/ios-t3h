//
//  DsPhimViewController.m
//  DatVeXemPhim
//
//  Created by Cuong on 5/20/15.
//  Copyright (c) 2015 Cuong. All rights reserved.
//

#import "DsPhimViewController.h"
#import "CustomTableViewCell.h"
#import "Phim.h"
#import "ChiTietPhimViewController.h"

@interface DsPhimViewController ()

@end

@implementation DsPhimViewController

@synthesize dsPhimTableView, danhSachPhim, phimDangChieu, phimSapChieu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Đặt tiêu đề trang
    self.title = @"Lịch chiếu phim";
    
    // Lấy đường dẫn database
    [self getDataPath];
    // Lấy danh sách phim từ database
    danhSachPhim = [Phim layDsPhim:db withPath:dataPath];
    
    // Tạo danh sách phim đang chiếu/sắp chiếu
    [self taoLichChieuPhim];
    danhSachPhim = phimDangChieu;
}

// Tạo lịch Đang chiếu và Sắp chiếu cho danh sách phim dựa vào ngày chiếu so với ngày hiện tại
- (void)taoLichChieuPhim {
    // Khởi tạo 2 danh sách phim
    phimDangChieu = [[NSMutableArray alloc] init];
    phimSapChieu = [[NSMutableArray alloc] init];
    // Tạo định dạng thời gian tương ứng
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    // Lấy ngày hiện tại, trường hợp này là gán đại 1 ngày
    NSDate *date1 = [dateFormatter dateFromString:@"01-01-2014"];
    for (Phim *phim in danhSachPhim) {
        NSDate *date2 = [dateFormatter dateFromString:phim.ngayKhoiChieu];
        // So sánh ngày chiếu với ngày hiện tại
        if ([date1 compare:date2] == NSOrderedDescending) { // Nhỏ hơn ngày hiện tại: đang chiếu
            [phimDangChieu addObject:phim];
        } else {    // Lớn hơn ngày hiện tại: sắp chiếu
            [phimSapChieu addObject:phim];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [danhSachPhim count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Khởi tạo Cell Custom
    CustomTableViewCell *cell = [dsPhimTableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Phim *phim = [danhSachPhim objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.thumbnailImagaView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", phim.soThuTu - 1]];
    cell.tenPhimLabel.text = phim.tenPhim;
    cell.diemDgLabel.text = [NSString stringWithFormat:@"%.2f", phim.diemDanhGia];

    // Thay đổi height của table cell
    tableView.rowHeight = 64;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChiTietPhimViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"chiTietPhimViewController"];
    
    Phim *phim = [danhSachPhim objectAtIndex:indexPath.row];
    // Gán dữ liệu cho Detail view
    [detailView setPhim:phim withImage:[NSString stringWithFormat:@"%d.jpg", phim.soThuTu - 1]];
    // Push detail view
    [self.navigationController pushViewController:detailView animated:YES];
    // Bỏ chọn dòng vừa click
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

- (IBAction)chooseDsPhimSegmentDidTouch:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        danhSachPhim = phimDangChieu;
    } else {
        danhSachPhim = phimSapChieu;
    }
    [dsPhimTableView reloadData];
}

@end
