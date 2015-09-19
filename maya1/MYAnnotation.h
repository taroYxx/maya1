//
//  MYAnnotation.h
//  maya1
//
//  Created by Taro on 15/7/25.
//  Copyright (c) 2015年 Taro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "MYdetailbutton.h"

@interface MYAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy, nullable) NSString *title;
@property (nonatomic,copy, nullable) NSString *subtitle;
@property (nonatomic,copy, nullable) MYdetailbutton *button;
@property (nonatomic,copy, nullable) NSString *icon;

@end
