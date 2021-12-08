#!/usr/bin/env python3

import requests
import argparse
import json
import sys
import os

parser = argparse.ArgumentParser(description="Display currencies on polybar")
parser.add_argument("--coins", type=str,
                    nargs="+", help="Select coins to display")
parser.add_argument("--base", type=str,
                    nargs="?", default="USD", help="Currency base to convert against")
parser.add_argument("--decimals", type=int,
                    nargs="?", default=2, help="How many decimals to show")
parser.add_argument("--display", type=str,
                    nargs="?", default="price", choices=["price", "percentage", "both"], help="Display mode")
parser.add_argument("--apikey", type=str,
                    nargs="?",default=None, help="Visit https://developers.coinranking.com/create-account to make an account and generate a free API key.")

args = parser.parse_args()
home = os.path.expanduser("~/")

unicode_dict = {}
with open(f"{home}.config/polybar/scripts/coins.svg", "r", encoding="utf-8") as icons:
    for line in icons:
        unicode, coin = line.strip().split(":")
        unicode_dict[unicode] = coin

if not (args.coins and args.apikey):
    parser.print_help()
    parser.exit()

coin_args_list = map(lambda x: f'symbols[]={x}', args.coins)
coin_args_str = "&".join(coin_args_list)

get_base = requests.get(
    f"https://api.coinranking.com/v2/reference-currencies?search={args.base}",
    headers={'x-access-token': args.apikey}).json()["data"]

get_base = get_base['currencies'][0]

get_coin = requests.get(
    f"https://api.coinranking.com/v2/coins?{coin_args_str}&referenceCurrencyUuid={get_base['uuid']}",
    headers={'x-access-token': args.apikey}).json()['data']

for n in range(len(args.coins)):
    coin = get_coin['coins'][n]
    price_float = round(float(coin['price']), args.decimals)
    delta = coin['change']
    
    for _unicode, _coin in unicode_dict.items():
        if _coin == coin['symbol'].lower():
            icon = chr(int(_unicode, 16)) if len(_unicode) > 1 else _unicode
    
    current_price = get_base['sign'] + str(price_float)

    if args.display == "price":
        sys.stdout.write(f" {icon} {current_price} ")
    elif args.display == "percentage":
        sys.stdout.write(f"  {icon} {delta:+}% ")
    elif args.display == "both":
        sys.stdout.write(f" {icon} {current_price} | {delta:+}% ")
