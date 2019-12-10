Class {
	#name : #APrioriMetricTest,
	#superclass : #TestCase,
	#instVars : [
		'apriori',
		'itemsets',
		'rules'
	],
	#category : #'APriori-Tests'
}

{ #category : #running }
APrioriMetricTest >> setUp [ 
	| counts |
	super setUp.
	
	itemsets := #((eggs)(milk)(butter)(bacon)(bread)(eggs bacon)(butter bread))
		collect: #asItemset.
		
	counts := #(3 2 3 2 3 2 2).
	
	rules := { 
		#(eggs) asItemset => #(bacon) asItemset .
		#(bacon) asItemset => #(eggs) asItemset .
		#(butter) asItemset => #(bread) asItemset .
		#(bread) asItemset => #(butter) asItemset }.
		
	rules first parentItemset: #(eggs bacon) asItemset.
	rules second parentItemset: #(eggs bacon) asItemset.
	rules third parentItemset: #(butter bread) asItemset.
	rules fourth parentItemset: #(butter bread) asItemset.
	
	apriori := APriori new.
	apriori numberOfTransactions: 6.
	apriori frequentItemsets: (Dictionary newFromKeys: itemsets andValues: counts).
]
