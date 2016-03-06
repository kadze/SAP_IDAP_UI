//
//  NSString+SAPURL.h
//  IOSProject
//
//  Created by S A P on 3/6/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SAPURL)
+ (NSString *)fileNameFromURL:(NSURL *)url;
+ (NSURL *)urlFromFileName:(NSString *)fileName;

@end
