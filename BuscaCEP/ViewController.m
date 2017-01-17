//
//  ViewController.m
//  BuscaCEP
//
//  Created by David Pagliotto on 1/16/17.
//  Copyright © 2017 dpagliotto. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <AFNetworking/AFNetworking.h>


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtCEP;
@property (weak, nonatomic) IBOutlet UIButton *btnConsultar;

@end

#define kCep         @"cep"
#define kUF          @"uf"
#define kLocalidade  @"localidade"
#define kBairro      @"bairro"
#define kLogradouro  @"logradouro"
#define kComplemento @"complemento"
#define kUnidade     @"unidade"
#define kIbge        @"ibge"
#define kGia         @"gia"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)consultarCEP:(id)sender {
    
    NSString *cep = [[self.txtCEP.text stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    NSString *url = [NSString stringWithFormat:@"https://viacep.com.br/ws/%@/json", cep];
    
    [[AFHTTPSessionManager manager] GET:url
                             parameters:nil
                               progress:nil
                                success:^(NSURLSessionDataTask * task, NSDictionary *responseObject) {
                                    NSLog(@"%@", responseObject);
                                    
                                    if ([[responseObject allKeys] count] > 1)
                                        [self preencheDados:responseObject];
                                    else
                                        [self preencheDados:nil];
                                }
                                failure:^(NSURLSessionDataTask * task, NSError *error) {
                                    NSLog(@"%@", error);
                                    
                                    [self preencheDados:nil];
                                }];
}

-(void)preencheDados:(NSDictionary *)dados
{
    CGFloat x = 20;
    CGFloat y = 95;
    CGFloat h = 23;
    CGFloat w = 1000;
    
    
    UILabel *label = [self.view viewWithTag:1000];
    if (!label)
        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [label setTag:1000];
    if (dados)
        label.text = [NSString stringWithFormat:@"CEP: %@", [dados valueForKey:kCep]];
    else
        label.text = @"";
    [self.view addSubview:label];
    y += h;
    
    label = [self.view viewWithTag:1001];
    if (!label)
        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [label setTag:1001];
    if (dados)
        label.text = [NSString stringWithFormat:@"Cidade/UF: %@/%@", [dados valueForKey:kLocalidade], [dados valueForKey:kUF]];
    else
        label.text = @"";
    [self.view addSubview:label];
    y += h;
    
    label = [self.view viewWithTag:1002];
    if (!label)
        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [label setTag:1002];
    if (dados)
        label.text = [NSString stringWithFormat:@"Bairro: %@", [dados valueForKey:kBairro]];
    else
        label.text = @"";
    [self.view addSubview:label];
    y += h;
    
    label = [self.view viewWithTag:1003];
    if (!label)
        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [label setTag:1003];
    if (dados)
        label.text = [NSString stringWithFormat:@"Logradouro: %@", [dados valueForKey:kLogradouro]];
    else
        label.text = @"";
    [self.view addSubview:label];
    y += h;
    
    label = [self.view viewWithTag:1004];
    if (!label)
        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [label setTag:1004];
    if (dados)
        label.text = [NSString stringWithFormat:@"Complemento: %@", [dados valueForKey:kComplemento]];
    else
        label.text = @"";
    [self.view addSubview:label];
    y += h;
    
    label = [self.view viewWithTag:1005];
    if (!label)
        label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    [label setTag:1005];
    if (dados)
        label.text = [NSString stringWithFormat:@"IBGE: %@ - GIA: %@", [dados valueForKey:kIbge], [dados valueForKey:kGia]];
    else
        label.text = @"";
    [self.view addSubview:label];
    y += h;
}

@end
