Class {
	#name : #APrioriItemsetCounterTest,
	#superclass : #TestCase,
	#instVars : [
		'counter'
	],
	#category : #'AI-APriori-Tests'
}

{ #category : #running }
APrioriItemsetCounterTest >> setUp [
	| arrayOfTransactions transactions | 
	super setUp.
	arrayOfTransactions := APrioriMockTransactions new transactions.
	transactions := APrioriTransactionsArray from: arrayOfTransactions.
	counter := APrioriItemsetCounter forTransactions: transactions.
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
