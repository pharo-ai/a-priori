Class {
	#name : #Basket,
	#superclass : #Bag,
	#category : #APriori
}

{ #category : #accessing }
Basket >> allPairs [
	"All possible pairs of elements from the basket.
	Example:"
	"#(1 3 1 3 2 4 2 1) asBasket allPairs >>> (Set withAll: (#((1 3)(1 2)(2 3)(2 4)(3 4)(1 4)) collect: #asSet))"
	
	| items |
	items := self items.
	
	^ items flatCollect: [ :firstItem |
		items 
			select: [ :secondItem |
				secondItem ~= firstItem ]
			thenCollect: [ :secondItem |
				Set with: firstItem with: secondItem ] ] 
]

{ #category : #accessing }
Basket >> items [
	"A set of items in this basket"
	"#(1 3 1 3 2 4 2 1) asBasket items >>> #(1 2 3 4) asSet"
	^ self asSet
]
