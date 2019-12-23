Extension { #name : #Object }

{ #category : #'*APriori' }
Object >> =!= anObject [
	"If anything else is compared to APrioriItemset or APrioriAssociationRule, the default equality operation is invoked which should normally return false"
	^ self = anObject
]
