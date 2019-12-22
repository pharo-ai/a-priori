Class {
	#name : #APrioriFrequentItemsetsSelectorTest,
	#superclass : #TestCase,
	#instVars : [
		'frequentItemsetsSelector'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriFrequentItemsetsSelectorTest >> setUp [ 
	| arrayOfTransactions transactions |
	super setUp.
	
	arrayOfTransactions := APrioriMockTransactions new transactions.
	transactions := APrioriTransactionsArray from: arrayOfTransactions.
	frequentItemsetsSelector := APrioriFrequentItemsetsSelector forTransactions: transactions.
]

{ #category : #tests }
APrioriFrequentItemsetsSelectorTest >> testMinCount [
	frequentItemsetsSelector minCount: 2.
	self assert: frequentItemsetsSelector minCount equals: 2.
]

{ #category : #tests }
APrioriFrequentItemsetsSelectorTest >> testSelectFrequentItemsets [
	| candidates expected actual |
	
	candidates := #(
		(bread avocado)
		(bread butter)
		(bacon eggs)
		(milk cereal)) collect: #asItemset.
		
	expected := #(
		(bread butter)
		(bacon eggs)) collect: #asItemset.
		
	expected first count: 2.
	expected second count: 2.
		
	frequentItemsetsSelector minCount: 2.
	actual := frequentItemsetsSelector selectFrequentItemsets: candidates.
		
	self assert: actual equals: expected.
	
	actual with: expected do: [ :eachActual :eachExpected |
		self assert: (eachActual =!= eachExpected) ].
]
