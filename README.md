# exchange-bot

Source code for https://t.me/m3xan1k_exchange_bot


## Setup for self-hosting

- Copy `you_need.env` to `.env`
- Fill `.env` with your bot API token
- Run `docker-compose up -d`
- Enjoy


## Using

- Send currency code to bot and you will receive current value in rubles
- Send anything but not correct code and you will get help message with codes

Example:

```
Австралийский доллар/AUD
Азербайджанский манат/AZN
Фунт стерлингов Соединенного королевства/GBP
Армянских драмов/AMD
Белорусский рубль/BYN
Болгарский лев/BGN
Бразильский реал/BRL
Венгерских форинтов/HUF
Гонконгских долларов/HKD
Датская крона/DKK
Доллар США/USD
Евро/EUR
Индийских рупий/INR
Казахстанских тенге/KZT
Канадский доллар/CAD
Киргизских сомов/KGS
Китайский юань/CNY
Молдавских леев/MDL
Норвежских крон/NOK
Польский злотый/PLN
Румынский лей/RON
СДР (специальные права заимствования)/XDR
Сингапурский доллар/SGD
Таджикских сомони/TJS
Турецких лир/TRY
Новый туркменский манат/TMT
Узбекских сумов/UZS
Украинских гривен/UAH
Чешских крон/CZK
Шведских крон/SEK
Швейцарский франк/CHF
Южноафриканских рэндов/ZAR
Вон Республики Корея/KRW
Японских иен/JPY
```


```
> eur

Currency: Евро
Code: EUR
Value: 90.1006

> usd

Currency: Доллар США
Code: USD
Value: 73.6992
```

## TODO:

- [x] Docker
- [x] Comments
- [x] Docs
- [ ] Test
