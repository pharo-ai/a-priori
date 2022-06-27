Class {
	#name : #APrioriMetricTest,
	#superclass : #TestCase,
	#instVars : [
		'itemsets',
		'rules'
	],
	#category : #'AI-APriori-Tests'
}

{ #category : #running }
APrioriMetricTest >> setUp [ 
	| counts |
	super setUp.
	
	itemsets := #((eggs)(milk)(butter)(bacon)(bread)(eggs bacon)(butter bread)).
	counts := #(3 2 3 2 3 2 2).
		
	itemsets := itemsets with: counts collect: [ :itemset :count |
		itemset
			asItemset
			count: count;
			yourself ].
	
	rules := { 
		itemsets first => itemsets fourth .
		itemsets fourth => itemsets first .
		itemsets third => itemsets fifth .
		itemsets fifth => itemsets third }.
		
	rules first parentItemset: itemsets sixth.
	rules second parentItemset: itemsets sixth.
	rules third parentItemset: itemsets seventh.
	rules fourth parentItemset: itemsets seventh.
]
