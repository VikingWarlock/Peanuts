//
//  PublicLib.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//


#ifndef Peanut_Mark1_PublicLib_h



#define SelfScreenbounds  [UIScreen mainScreen].bounds

#define USER_Token @"PHPSESSID"

#define USER_UID_Fetch @"self_uid"

#define AES_Private_key @"4652b19e09ced75df510bf5a263a2bfe"


#define USER_PHPSESSID [[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token]

#define USER_UID [[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_UID_Fetch]

#define Peanut_Mark1_PublicLib_h

#define TableView_Background_Color_Gray [UIColor colorWithRed:0.937255 green:0.937255 blue:0.956863 alpha:1]
#define Dark_Red [UIColor colorWithRed:153.0/255.0 green:50.0/255.0 blue:51.0/255.0 alpha:1]
#define HEIGHT_OF_HEADER_OR_FOOTER 30.0

#endif
