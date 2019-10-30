Extension { #name : #Collection }

{ #category : #'*APriori' }
Collection >> asBasket [
	"Answer a Basket whose elements are the elements of the receiver."

	^ Basket withAll: self
]
