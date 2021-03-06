# OptionPricer
Implementation of the well known Black-Scholes-Formula with Swift as a school project

This project was a mandatory part of my education during my final year at the Kantonsschule Zug. This app called "European Stock Option
Calculator" was developed for Apple's iOS platform and was fully written in the language Swift. I implemented the famous Black-Scholes
Model that has been invented in 1973 by the two economists Fischer Black und Myron Samuel Scholes and whose work has been awarded with a
Nobel Prize.

The formula is pretty simple and allows everyone to easily calculate the price of an European call and put option. The formula needs the 
current stock price, strike price, expected volatility, expected interest rates and the time left to the option's expiry date in
order to calculate the price of an European-styled option.

In addition to that, my app also allows the user to fetch the the current price of a stock (e.g. starting a query with "MSFT" will return
the actual price in $ at that given moment) and to automatically calculate the difference in days between two dates.

Here are some pictures of my app:

![alt tag](https://i.imgur.com/lODP0AL.png "Loading page and the UI")

Loading page and the easy to use UI with the option to input different values in order to calculate the price of an option.

![alt tag](https://i.imgur.com/vE274KU.png "Fetching the price of the the Microsoft stock and the calculation of the difference between two dates")

Fetching the price of a single Microsoft stock and the calculation of the difference between two dates.
