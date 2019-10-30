Extension { #name : #Association }

{ #category : #'*APriori' }
Association >> asAssociationRule [
	^ AssociationRule key: self key value: self value
]
