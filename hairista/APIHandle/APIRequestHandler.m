//
//  APIRequestHandler.m
//  demo_Get_Data_API
//
//  Created by Dong Vo on 4/2/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "APIRequestHandler.h"

#import <AFNetworking/AFNetworking.h>

#import "Common.h"


@interface APIRequestHandler ()
@end

@implementation APIRequestHandler




+ (void)initWithURLString:(NSString *)url withHttpMethod:(NSString *)httpMethod withRequestBody:(id)requestBody callApiResult:(CallAPIResult)callAPIResult
{
    
    if(![Common checkForWIFIConnection]){
    
        callAPIResult(TRUE, @"Không thể kết nối với máy chủ \nVui lòng kiểm tra kết nối internet của bạn và thử lại.", nil);
        return;

    }
    
    
    NSError *error = nil;
    NSData *jsonBody = nil;
    
    if (requestBody) {
        jsonBody = [NSJSONSerialization dataWithJSONObject:requestBody options:0 error:&error];
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.timeoutInterval = 60;
    
    [request setHTTPMethod:httpMethod];
    [request setHTTPBody:jsonBody];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[NSString stringWithFormat:@"Bearer {{%@}}",Appdelegate_hairista.sessionUser.token] forHTTPHeaderField:@"Authorization"];
    
    NSLog(@"%@",[NSString stringWithFormat:@"Bearer {{%@}}",Appdelegate_hairista.sessionUser.token]);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    NSURLSessionDataTask *dataTask;
    
     dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if(error){
        
            if(responseObject){
            
                id arrMsg = [responseObject objectForKey:@"msg"];
                
                if([arrMsg isKindOfClass:[NSArray class]]){
                
                    if([[arrMsg firstObject] length] > 0){
                        
                        callAPIResult(true,[arrMsg firstObject],nil);
                    }

                }
                else{
                
                    callAPIResult(true,arrMsg,nil);

                }
                
            }
            else{
            
                callAPIResult(true,error.localizedDescription,nil);
            }
        
        }
        else{
        
            callAPIResult(false,nil,responseObject);
        }
    }];
    
    [dataTask resume];
}

@end
