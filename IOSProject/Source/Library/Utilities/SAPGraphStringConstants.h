//
//  SAPGraphStringConstants.h
//  IOSProject
//
//  Created by SAP on 3/22/16.
//  Copyright © 2016 SAP. All rights reserved.
//

#define SAPNSStringConst(name, value) static NSString * const name = value

SAPNSStringConst(kSAPDataKey, @"data");
SAPNSStringConst(kSAPFieldsKey, @"fields");

SAPNSStringConst(kSAPUserGraphPath, @"me");

SAPNSStringConst(kSAPFriendsKey, @"friends");
SAPNSStringConst(kSAPAlbumsKey, @"albums");
SAPNSStringConst(kSAPPhotosKey, @"photos");

SAPNSStringConst(kSAPIDKey, @"id");
SAPNSStringConst(kSAPFirstNameKey, @"first_name");
SAPNSStringConst(kSAPLastNameKey, @"last_name");
SAPNSStringConst(kSAPGenderKey, @"gender");

/*
 
 square (50x50)
 small (50 pixels wide, variable height)
 normal (100 pixels wide, variable height), and
 large (about 200 pixels wide, variable height)
*/

SAPNSStringConst(kSAPPictureKey, @"picture");
SAPNSStringConst(kSAPLargePictureKey, @"picture.type(large)");
SAPNSStringConst(kSAPLargeSquarePictureKey, @"picture.width(200).height(200)");
SAPNSStringConst(kSAPSmallPictureKey, @"picture.type(square)");
SAPNSStringConst(kSAPNormalPictureKey, @"picture.type(normal)");
SAPNSStringConst(kSAPAlbumPictureKey, @"picture.type(album)");
SAPNSStringConst(kSAPSquarePictureKey, @"picture.type(square)");

SAPNSStringConst(kSAPLargePictureWithAliasKey, @"picture.type(large).as(picture_large)");
SAPNSStringConst(kSAPLargeSquarePictureWithAliasKey, @"picture.width(200).height(200).as(picture_large)");
SAPNSStringConst(kSAPSmallPictureWithAliasKey, @"picture.type(small).as(picture_small)");
SAPNSStringConst(kSAPNormalPictureWithAliasKey, @"picture.type(normal).as(picture_normal)");
SAPNSStringConst(kSAPAlbumPictureWithAliasKey, @"picture.type(album).as(picture_album)");
SAPNSStringConst(kSAPSquarePictureWithAliasKey, @"picture.type(square).as(picture_square)");

SAPNSStringConst(kSAPLargePictureAliasKey, @"picture_large");
SAPNSStringConst(kSAPSmallPictureAliasKey, @"picture_small");
SAPNSStringConst(kSAPNormalPictureAliasKey, @"picture_normal");
SAPNSStringConst(kSAPAlbumPictureAliasKey, @"picture_album");
SAPNSStringConst(kSAPSquarePictureAliasKey, @"picture_square");

SAPNSStringConst(kSAPUrlKey, @"url");
