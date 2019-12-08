Extension { #name : #Association }

{ #category : #'*APriori' }
Association >> asAssociationRule [
	^ APrioriAssociationRule key: self key value: self value
]
