//
//  SAPJSONRepresentable.h
//  IOSProject
//
//  Created by Andrey on 4/15/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAPJSONRepresentable <NSObject>
@optional
- (id)JSONRepresentation;

@end
