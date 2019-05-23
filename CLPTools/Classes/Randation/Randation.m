//
//  Randation.m
//  DHCiphertext
//
//  Created by 曹郎鹏 on 14-1-26.
//
//

#import "Randation.h"

@implementation Randation

int flag_num = 1,flag_zmdx = 1 ,flag_zmxx = 1;

int n1,x1,x2,l1,m1,a111;

NSString *a1,*b1,*c1,*d1,*e1,*f1;
char array[20];



//一键生成密码
+ (NSString *)getmm :(NSString *)bzcount
{
    
    NSString *shengchenstr;
    
      srand((unsigned int)time(NULL));
    
             int bz = [bzcount intValue] ;
  
                    n1 = bz / 3;
                    l1 = bz % 3;
                    
                    
                    m1 = pow (10,bz-n1*2-1);
                    x1 = m1 + rand () % ( 9 * m1 )  ;
 
                    a1 = [NSString stringWithFormat:@"%d",x1];
                    
                    
                    for (int h1 = 0; h1 < n1 ; h1++)
                    {
                        
                        array[h1] = 'A'+rand () % 26;
                      //  NSLog(@"111111%c",array[h1]);
                        
                        
                    }
                    
                    for (int s1 = n1; s1 < n1*2 ; s1++)
                    {
                        array[s1] = 'a'+rand () % 26;
                       // NSLog(@"2222222%c",array[s1]);
                        
                    }
                    
                    b1 = [[NSString alloc]initWithFormat:@"%s", array];
                    c1=[a1 stringByAppendingFormat:b1 ];
                    
                    // myLabel_shengchen.text = c1;
                    //////
                    
                    NSString *xp1;
                    NSMutableString  *xp2;
                    
                    xp2 = [[NSMutableString alloc] init];
                    
                    char     chr[20];
                    for(int p1 = 0; p1 < bz; p1++)
                    {
                        chr[p1] = [c1 characterAtIndex:p1];
                       // NSLog(@"%c",chr[p1]);
                    }
                    chr[bz] = '\0';
                    
                    int  shuzu[20];
                    int  xp;
                    for (int p = 0; p < bz; p++)
                    {
                        
                      //  NSLog(@"p的结果为：    %i",p);
                        //  NSLog(@"yyyyyxxxx  %i",bz1);
                        int flag = 0;
                        do
                        {
                            xp =rand()% (bz);
                            shuzu[p] = xp ;
                            flag = 0;
                            
                            for (int ii = 0; ii < p; ii++)
                            {
                                if( xp == shuzu[ii] )
                                {
                                    flag = 1;
                                }
                            }
                            
                        } while (flag == 1);
                        
                      //  NSLog(@"xxxxxx%c",chr[xp]);
                        xp1 = [NSString stringWithFormat:@"%c", chr[xp]];
                       // NSLog(@"xp1的结果为：   %@\n",xp1);
                        [xp2 appendString:xp1];
                       // NSLog(@"xp2的结果为：   %@\n\n",xp2);
                        
                        
                        
                    }
            
            
                    shengchenstr = xp2;
                    return shengchenstr;
 
     return @"0";
    
}

@end
