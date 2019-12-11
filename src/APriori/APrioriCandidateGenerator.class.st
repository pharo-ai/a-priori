Class {
	#name : #APrioriCandidateGenerator,
	#superclass : #Object,
	#category : #APriori
}

{ #category : #'as yet unclassified' }
APrioriCandidateGenerator >> canItemset: firstItemset beJoinedWith: secondItemset [
	"Test if one itemset can be joined with another. For that the two itemsets of size k must share the first k-1 elements and the last element of secondItemset must be greater than the last element of firstItemset"
	| itemset1WithoutLast itemset2WithoutLast |
	
	itemset1WithoutLast := firstItemset copyFrom: 1 to: firstItemset size - 1.
	itemset2WithoutLast := secondItemset copyFrom: 1 to: secondItemset size - 1.
	
	^ (itemset1WithoutLast = itemset2WithoutLast) and: (firstItemset last < secondItemset last).
]

{ #category : #'as yet unclassified' }
APrioriCandidateGenerator >> generateCandidatesFrom: previousFrequentItemsets [
	"Join step of candidate generation"
	| candidateItemsets |
	candidateItemsets := self joinItemsets: previousFrequentItemsets.
	candidateItemsets := self pruneItemsets: candidateItemsets basedOn: previousFrequentItemsets.
	^ candidateItemsets 
	
]

{ #category : #'as yet unclassified' }
APrioriCandidateGenerator >> joinItemset: firstItemset with: secondItemset [
	"Join one itemset with another. This operation should only be performed after we test that two itemsets can be joined (see canItemset:beJoinedWith:). This means that two itemsets of size k have the same first k-1 elements and the last element of secondItemset is greater than the last element of firstItemset. We join them by creating an itemset of size k+1 where first k-1 elements are the same as in firstItemset (or secondItemset), element k is the last element of firstItemset, and element k+1 is the last element of secondItemset (this way, the elements of a new itemset are sorted in ascending order)"
	| newItemset |
	newItemset := firstItemset copy.
	newItemset add: secondItemset last.
	^ newItemset
]

{ #category : #'as yet unclassified' }
APrioriCandidateGenerator >> joinItemsets: itemsets [
	^ itemsets flatCollect: [ :itemset1 |
		itemsets
			select: [ :itemset2 | self canItemset: itemset1 beJoinedWith: itemset2 ]
			thenCollect: [ :itemset2 | self joinItemset: itemset1 with: itemset2 ] ].
]

{ #category : #'as yet unclassified' }
APrioriCandidateGenerator >> pruneItemsets: itemsets basedOn: previousFrequentItemsets [
	"Prune step of candidate generation"
	^ itemsets select: [ :itemset |
		itemset allLargestSubsets allSatisfy: [ :subset |
			previousFrequentItemsets includes: subset ] ].
]
