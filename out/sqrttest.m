#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>


int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  printf("%d %d %d %d %d %d ", (int)sqrt(4), (int)sqrt(16), (int)sqrt(20), (int)sqrt(1000), (int)sqrt(500), (int)sqrt(10));
  [pool drain];
  return 0;
}


