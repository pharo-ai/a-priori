Class {
	#name : #AssociationRuleTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
AssociationRuleTest >> setUp [ 
	super setUp.
	transactions := APrioriMockTransactions new transactions.
]

{ #category : #'as yet unclassified' }
AssociationRuleTest >> testConfidenceIn [
	| itemset rules expected actual |
	
	itemset := #(bread avocado butter bananas) asItemset.
	rules := itemset allAssociationRules.
	
	expected := {
		(#(bread) asItemset => #(avocado butter bananas) asItemset) -> (1/3) .
		(#(avocado) asItemset => #(bread butter bananas) asItemset) -> 1 .
		(#(butter) asItemset => #(bread avocado bananas) asItemset) -> (1/3) .
		(#(bananas) asItemset => #(bread avocado butter) asItemset) -> 1 .
		(#(bread avocado) asItemset => #(butter bananas) asItemset) -> 1 .
		(#(bread butter) asItemset => #(avocado bananas) asItemset) -> (1/2) .
		(#(bread bananas) asItemset => #(avocado butter) asItemset) -> 1 .
		(#(avocado butter) asItemset => #(bread bananas) asItemset) -> 1 .
		(#(avocado bananas) asItemset => #(bread butter) asItemset) -> 1 .
		(#(butter bananas) asItemset => #(bread avocado) asItemset) -> 1 .
		(#(bread avocado butter) asItemset => #(bananas) asItemset) -> 1 .
		(#(bread avocado bananas) asItemset => #(butter) asItemset) -> 1 .
		(#(bread butter bananas) asItemset => #(avocado) asItemset) -> 1 .
		(#(avocado butter bananas) asItemset => #(bread) asItemset) -> 1
	} asDictionary.
	
	actual := (rules collect: [ :eachRule |
		eachRule -> (eachRule confidenceIn: transactions) ]) asDictionary.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
AssociationRuleTest >> testPrintOn [
	| itemset1 itemset2 rule stream expected actual |
	
	itemset1 := #(eggs milk butter) asItemset.
	itemset2 := #(avocado bananas) asItemset.
	rule := itemset1 => itemset2.
	
	stream := String new writeStream.
	rule printOn: stream.
	
	expected := '{butter, milk, eggs} => {avocado, bananas}'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]
