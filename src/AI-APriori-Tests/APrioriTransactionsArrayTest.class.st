Class {
	#name : #APrioriTransactionsArrayTest,
	#superclass : #TestCase,
	#instVars : [
		'transactions'
	],
	#category : #'AI-APriori-Tests'
}

{ #category : #running }
APrioriTransactionsArrayTest >> setUp [ 
	| arrayOfTransactions |
	super setUp.
	arrayOfTransactions := APrioriMockTransactions new transactions.
	transactions := APrioriTransactionsArray from: arrayOfTransactions.
]

{ #category : #tests }
APrioriTransactionsArrayTest >> testDo [
	| expected actual |
	
	expected := OrderedCollection withAll: #((eggs 3)(milk 2)(eggs 2)(bread 2)(bread 3)(bread 4)).
	actual := OrderedCollection new.
	
	transactions do: [ :transaction |
		actual add: { transaction first . transaction size } ].
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTransactionsArrayTest >> testItembase [
	| expected actual |
	
	expected := Set withAll: #(bread butter bananas avocado eggs milk cereal bacon).
	actual := transactions itembase.
	
	self assert: actual equals: expected.
]

{ #category : #tests }
APrioriTransactionsArrayTest >> testSize [
	self assert: transactions size equals: 6.
]
