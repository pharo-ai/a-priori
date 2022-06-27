Extension { #name : #Association }

{ #category : #'*AI-APriori' }
Association >> asAssociationRule [
	^ APrioriAssociationRule key: self key value: self value
]
