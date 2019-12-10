Class {
	#name : #APrioriItemsetCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriItemsetCounterTest >> setUp [
	| transactions transactionsDatabase | 
	super setUp.
	
	transactions := APrioriMockTransactions new transactions.
	transactionsDatabase := APrioriTransactionsArray from: transactions.
	counter := APrioriItemsetCounter forTransactions: transactionsDatabase.
]

{ #category : #tests }
APrioriItemsetCounterTest >> testCountOfItemset [
	| itemsets expected actual |
	
	itemsets := #((eggs)(milk)(butter)(bacon)(bread)(eggs bacon)(butter bread))
		collect: #asItemset.
		
	expected := #(3 2 3 2 3 2 2).
	actual := itemsets collect: [ :itemset | counter countOfItemset: itemset ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriItemsetCounterTest >> testCountOfNonexistingItemset [
	| itemset expected actual |
	
	itemset := #(this does not exist) asItemset.
		
	expected := 0.
	actual := counter countOfItemset: itemset.
	
	self assert: actual equals: expected.
]
