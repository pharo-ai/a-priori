Class {
	#name : #ItemsetsCollection,
	#superclass : #OrderedCollection,
	#category : #APriori
}

{ #category : #'gt-inspector-extension' }
ItemsetsCollection >> gtInspectorItemsIn: composite [
	"Hide Items from inspector"
]

{ #category : #'as yet unclassified' }
ItemsetsCollection >> gtInspectorItemsetsIn: composite [
	<gtInspectorPresentationOrder: 0>

	^ composite fastTable
		title: 'Itemsets';
		display: [ self ];
		beMultiple;
		enableElementIndex;
		wantsAutomaticRefresh: true;
		column: 'Index' evaluated: [ :itemset :index | index ] width: 50;
		column: 'Itemset' evaluated: [ :itemset | itemset asString ];
		column: 'Count' evaluated: [ :itemset | itemset count ] width: 50;
		column: 'Support' evaluated: [ :itemset | itemset support asFloat ] width: 60;
		send: [ :result | 
			"withSmalltalkSearch;
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'."
			result
				ifNil: [ nil ]
				ifNotNil: [ result size = 1
						ifTrue: [ result anyOne ]
						ifFalse: [ self species withAll: result ]
					]
			]
]
