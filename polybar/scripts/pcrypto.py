#!/usr/bin/env python3

import requests
import argparse
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

args = parser.parse_args()
path = os.getcwd()

if not os.path.exists(f"{path}/scripts/apikey.txt"):
    sys.stdout.write("API Key not found. Please add to apikey.txt")
    with open('apikey.txt', 'w') as fp:
        fp.write("# Visit https://developers.coinranking.com/create-account to make an account and generate a free API key.\n# ADD YOUR API KEY ON A NEW LINE BELOW HERE.")

else:

    with open(f'{path}/scripts/apikey.txt', 'r') as fp:
        apikey = [line for line in fp.readlines() if not line.startswith("#")][0]
        apikey = str(apikey).replace("\n", "")

    unicode_dict = {}
    with open(f"{path}/scripts/coins.svg", "r", encoding="utf-8") as icons:
        for line in icons:
            unicode, coin = line.strip().split(":")
            unicode_dict[unicode] = coin

    if not (args.coins and args.base):
        parser.print_help()
        parser.exit()

    coin_args_list = map(lambda x: f'symbols[]={x}', args.coins)
    coin_args_str = "&".join(coin_args_list)

    get_base = requests.get(
        f"https://api.coinranking.com/v2/reference-currencies?search={args.base}",
        headers={'x-access-token': apikey}).json()["data"]

    get_base = get_base['currencies'][0]

    get_coin = requests.get(
        f"https://api.coinranking.com/v2/coins?{coin_args_str}&referenceCurrencyUuid={get_base['uuid']}",
        headers={'x-access-token': apikey}).json()['data']

    for n in range(len(args.coins)):
        coin = get_coin['coins'][n]
        price_float = round(float(coin['price']), args.decimals)
        delta = coin['change']

        current_price = get_base['sign'] + str(price_float)

        if args.display == "price":
            sys.stdout.write(f" {coin['symbol']} {current_price} ")
        elif args.display == "percentage":
            sys.stdout.write(f"  {coin['symbol']} {delta:+}% ")
        elif args.display == "both":
            sys.stdout.write(f" {coin['symbol']} {current_price} | {delta:+}% ")
