# APriori

[![Build Status](https://travis-ci.org/olekscode/APriori.svg?branch=master)](https://travis-ci.org/olekscode/APriori)
[![Build status](https://ci.appveyor.com/api/projects/status/dj2c543kga1vxmrq?svg=true)](https://ci.appveyor.com/project/olekscode/apriori)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/APriori/badge.svg?branch=master)](https://coveralls.io/github/olekscode/APriori?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/APriori/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-6.1-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)

Implementation of A-Priori algorithm in Pharo

## Installation
To install APriori, go to the Playground (`Ctrl+OW`) in your Pharo image and execute the following Metacello script (select it and press Do-it button or `Ctrl+D`):

```smalltalk
Metacello new
  baseline: 'APriori';
  repository: 'github://olekscode/APriori/src';
  load.
```

## How to use it?

Create a list of transactions. Each transaction is an itemset (for example, a list of products that were purchased together by one customer).

```Smalltalk
transactions := #( 
  (eggs milk butter)
  (milk cereal)
  (eggs bacon)
  (bread butter)
  (bread bacon eggs)
  (bread avocado butter bananas)).
```

Initialize an APriori algorithm with a support and confidence thresholds:

```Smalltalk
apriori := APriori
  transactions: transactions
  supportThreshold: 1/3
  confidenceThreshold: 1/3.
```

Now you can find frequent itemsets - sets of items that are likely to be purchased together:

```Smalltalk
itemsets := apriori frequentItemsets.

" anArray(
  {bread, butter}
  {eggs, bacon}
)"
```

Or generate association rules in the form `key => value` where a set of items `value` will be recommended to a customer who purchases a set of items `key`:

```Smalltalk
rules := apriori associationRules.

" anArray(
  {bread} => {butter}
  {butter} => {bread}
  {eggs} => {bacon}
  {bacon} => {eggs}
)"
```

Every itemset knows its count and support:

```Smalltalk
itemset := itemsets first. "{bread, butter}"
itemset count. "2"
itemset support. "1/3"
```

Similarly, every rule knows its count, support, confidence, and lift:

```Smalltalk
rule := rules first. "{bread} => {butter}"
rule count. "2"
rule support. "1/3"
rule confidence. "2/3"
rule lift. "4/3"
```

## Real-world example

Download the [Groceries dataset](https://github.com/stedy/Machine-Learning-with-R-datasets/blob/master/groceries.csv). It contains 1 month (30 days) of real-world point-of-sale transaction data from a typical local grocery outlet. The dataset contains 9835 transactions and the items are aggregated to 169 categories. We load the contents of `groceries.csv` into Pharo, split it by lines and then by commas to get a collection of transactions:

```Smalltalk
file := '/path/to/groceries.csv' asFileReference.
lines := Character lf split: file contents.
groceries := lines collect: [ :line | $, split: line ].
```

Now we initialize an A-Priori algorithm with support threshold of 1% and confidence threshold of 50%:

```Smalltalk
apriori := APriori
  transactions: groceries
  supportThreshold: 0.01
  confidenceThreshold: 0.5.
```

We generate association rules (this can take about a minute):

```Smalltalk
rules := apriori associationRules.
```

And sort them by lift in descending order:

```Smalltalk
rules sort: [ :a :b | a lift > b lift ].
```

This will produce the following 15 rules:

```
{citrus fruit, root vegetables} => {other vegetables}
{root vegetables, tropical fruit} => {other vegetables}
{rolls/buns, root vegetables} => {other vegetables}
{root vegetables, yogurt} => {other vegetables}
{curd, yogurt} => {whole milk}
{butter, other vegetables} => {whole milk}
{root vegetables, tropical fruit} => {whole milk}
{root vegetables, yogurt} => {whole milk}
{domestic eggs, other vegetables} => {whole milk}
{whipped/sour cream, yogurt} => {whole milk}
{rolls/buns, root vegetables} => {whole milk}
{other vegetables, pip fruit} => {whole milk}
{tropical fruit, yogurt} => {whole milk}
{other vegetables, yogurt} => {whole milk}
{other vegetables, whipped/sour cream} => {whole milk}
```

Which means that we will recommend `other vegetables` to the customers who purchased `citrus fruit` and `root vegetables`. And for those who took `curd` and `yogurt` we will recommend the `whole milk`.
