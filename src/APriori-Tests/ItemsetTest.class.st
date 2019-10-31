Class {
	#name : #ItemsetTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
ItemsetTest >> setUp [ 	
	super setUp.
	transactions := APrioriMockTransactions new transactions
]

{ #category : #tests }
ItemsetTest >> testAllAssociationRules [
	| itemset expected actual |
	
	itemset := #(bread avocado butter bananas) asItemset.
	
	expected := {
		#(bread) asItemset => #(avocado butter bananas) asItemset . 
		#(avocado) asItemset => #(bread butter bananas) asItemset .
		#(butter) asItemset => #(bread avocado bananas) asItemset .
		#(bananas) asItemset => #(bread avocado butter) asItemset .
		#(bread avocado) asItemset => #(butter bananas) asItemset .
		#(bread butter) asItemset => #(avocado bananas) asItemset .
		#(bread bananas) asItemset => #(avocado butter) asItemset .
		#(avocado butter) asItemset => #(bread bananas) asItemset .
		#(avocado bananas) asItemset => #(bread butter) asItemset .
		#(butter bananas) asItemset => #(bread avocado) asItemset .
		#(bread avocado butter) asItemset => #(bananas) asItemset .
		#(bread avocado bananas) asItemset => #(butter) asItemset .
		#(bread butter bananas) asItemset => #(avocado) asItemset .
		#(avocado butter bananas) asItemset => #(bread) asItemset }.
	
	actual := itemset allAssociationRules.
	
	"We don't care about the order"
	expected := expected asSet.
	actual := actual asSet.
	
	self assert: actual equals: expected.
	
]

{ #category : #tests }
ItemsetTest >> testAllSubsets [
	| itemset expected actual |
	
	itemset := #(bread avocado butter bananas) asItemset.
	
	expected := #(
		(bread)
		(avocado)
		(butter)
		(bananas)
		(bread avocado)
		(bread butter)
		(bread bananas)
		(avocado butter)
		(avocado bananas)
		(butter bananas)
		(bread avocado butter)
		(bread avocado bananas)
		(bread butter bananas)
		(avocado butter bananas)
	) collect: #asItemset.
	
	actual := itemset allSubsets.
	
	"We don't care about the order"
	expected := expected asSet.
	actual := actual asSet.
	
	self assert: actual equals: expected.
	
]

{ #category : #tests }
ItemsetTest >> testAsArray [ 
	| array itemset expected actual |
	array := #(bread butter avocado).
	itemset := array asItemset.
	actual := itemset asArray.
	expected := array sorted.
	self assert: actual equals: expected.
]

{ #category : #tests }
ItemsetTest >> testCanBeJoinedWith [
	| itemset1 itemset2 itemset3 |
	
	itemset1 := #(avocado bread butter) asItemset.
	itemset2 := #(avocado bread eggs) asItemset.
	itemset3 := #(bread eggs milk) asItemset.
	
	self assert: (itemset1 canBeJoinedWith: itemset2).
	self deny: (itemset2 canBeJoinedWith: itemset1).
	self deny: (itemset1 canBeJoinedWith: itemset3).
]

{ #category : #tests }
ItemsetTest >> testIsSupersetOf [
	| itemset1 itemset2 itemset3 |
	
	itemset1 := #(bread avocado butter bananas) asItemset.
	itemset2 := #(bread butter) asItemset.
	itemset3 := #(bread bacon) asItemset.
	
	self assert: (itemset1 isSupersetOf: itemset2).
	self assert: (itemset1 isSupersetOf: itemset1).
	self deny: (itemset2 isSupersetOf: itemset1).
	self deny: (itemset1 isSupersetOf: itemset3).
	
]

{ #category : #tests }
ItemsetTest >> testItemsetIsSorted [
	| itemset expected actual |
	
	itemset := #(g d a f h b i e c j) asItemset.
	expected := #(a b c d e f g h i j).
	actual := itemset asArray.
	
	self assert: actual equals: expected
]

{ #category : #tests }
ItemsetTest >> testJoinWith [
	| itemset1 itemset2 expected actual |
	
	itemset1 := #(avocado bread butter) asItemset.
	itemset2 := #(avocado bread eggs) asItemset.
	
	expected := #(avocado bread butter eggs) asItemset.
	actual := itemset1 joinWith: itemset2.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
ItemsetTest >> testPrintOn [
	| itemset stream expected actual |
	itemset := #(eggs milk butter) asItemset.
	
	stream := String new writeStream.
	itemset printOn: stream.
	
	expected := '{butter, eggs, milk}'.
	actual := stream contents.
	
	self assert: actual equals: expected.
]
