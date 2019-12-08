Extension { #name : #Collection }

{ #category : #'*APriori' }
Collection >> asItemset [
	"Answer an Itemset whose elements are the elements of the receiver."

	^ APrioriItemset withAll: self
]
