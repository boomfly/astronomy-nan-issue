import { Meteor } from 'meteor/meteor'
import { Class } from 'meteor/jagi:astronomy'

Meteor.startup ->
  # code to run on server at startup

Docs = new Mongo.Collection 'docs'

Doc = Class.create
  name: 'Doc'
  collection: Docs
  fields:
    meta: Object
newDoc = new Doc {
  meta:
    number: NaN
}
newDoc.save()

newDocId = newDoc._id

doc = Doc.findOne newDocId
doc.meta.number = 10
doc.save()

doc = Doc.findOne newDocId
console.log 'After astronomy update', doc.meta.number # Value still is NaN

# Then try 100% working method
Docs.update {_id: newDocId}, {
  $set:
    'meta.number': 10
}

doc = Doc.findOne newDocId
console.log 'After default Collection.update method', doc.meta.number # Value changed to 10
