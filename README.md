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
transactions := { 
  #(eggs milk butter) asItemset .
  #(milk cereal) asItemset .
  #(eggs bacon) asItemset .
  #(bread butter) asItemset .
  #(bread bacon eggs) asItemset .
  #(bread avocado butter bananas) asItemset
}.
```

Initialize an APriori algorithm with a support and confidence thresholds:

```Smalltalk
apriori := APriori
  supportThreshold: 2/6
  confidenceThreshold: 2/6.
```

Now you can find frequent itemsets - sets of items that are likely to be purchased together:

```Smalltalk
apriori frequentItemsetsIn: transactions.

" anArray(
  {bread, butter}
  {eggs, bacon}
)"
```

Or generate association rules in the form `key => value` where a set of items `value` will be recommended to a customer who purchases a set of items `key`:

```Smalltalk
apriori associationRulesFrom: transactions.

" anArray(
  {bread} => {butter}
  {butter} => {bread}
  {eggs} => {bacon}
  {bacon} => {eggs}
)"
```
