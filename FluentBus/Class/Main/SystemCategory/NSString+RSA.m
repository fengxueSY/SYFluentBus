//
//  NSString+RSA.m
//  FluentBus
//
//  Created by 张俊辉 on 16/12/31.
//  Copyright © 2016年 yang. All rights reserved.
//

#import "NSString+RSA.h"

@implementation NSString (RSA)


//RSA加密的两个方法
+ (NSString *)setPublicKey:(const char *)data Mod:(const char *)mod Exp:(const char *)exp
{
    RSA * pubkey = RSA_new();
    
    BIGNUM * bnmod = BN_new();
    BIGNUM * bnexp = BN_new();
    
    BN_hex2bn(&bnmod, (const char *) mod);
    BN_hex2bn(&bnexp, exp);
    
    pubkey->n = bnmod;
    pubkey->e = bnexp;
    
    int nLen = RSA_size(pubkey);
    char *crip = (char *)malloc(sizeof(char*)*nLen+1);
    
    //RSA_print_fp(stdout,pubkey,10);
    
    int nLen1 = RSA_public_encrypt(strlen((const char *) data), (const unsigned char *) data, (unsigned char *) crip, pubkey, RSA_PKCS1_PADDING );
    //NSLog(@"len size : %d",nLen1);
    if (nLen1 <= 0)
    {
        NSLog(@"erro encrypt");
    }
    else
    {
        
        NSLog(@"SUC encrypt");
        
    }
    
    free(crip);
    RSA_free(pubkey);
    
    NSData *resData = [NSData dataWithBytes:crip length:nLen];
    NSLog(@"%@",resData);
    return [self hex:resData useLower:NO];
}

+ (NSString *)hex: (NSData *)data useLower: (bool)isOutputLower
{
    static const char HexEncodeCharsLower[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };
    static const char HexEncodeChars[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    char *resultData;
    // malloc result data
    resultData = malloc([data length] * 2 +1);
    // convert imgData(NSData) to char[]
    unsigned char *sourceData = ((unsigned char *)[data bytes]);
    uint length = [data length];
    
    if (isOutputLower) {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeCharsLower[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeCharsLower[(sourceData[index] % 0x10)];
        }
    }
    else {
        for (uint index = 0; index < length; index++) {
            // set result data
            resultData[index * 2] = HexEncodeChars[(sourceData[index] >> 4)];
            resultData[index * 2 + 1] = HexEncodeChars[(sourceData[index] % 0x10)];
        }
    }
    resultData[[data length] * 2] = 0;
    
    // convert result(char[]) to NSString
    NSString *result = [NSString stringWithCString:resultData encoding:NSASCIIStringEncoding];
    sourceData = nil;
    free(resultData);
    
    return result;
}

@end
