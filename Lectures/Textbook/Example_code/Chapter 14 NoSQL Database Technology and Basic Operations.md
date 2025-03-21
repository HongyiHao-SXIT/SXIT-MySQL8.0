### Chapter 14 NoSQL Database Technology and Basic Operations

#### Example 14.1
Viewing and Creating a MongoDB Database
```
> // View reserved databases in MongoDB //
> show  dbs;
admin   0.000GB
config  0.000GB
local   0.000GB
> // Access the default database test //
> db
test
> // Create the database datamis //
> use datamis
switched to db datamis
> db.dropDatabase()
{ "ok" : 1 }
> show users
>
```

#### Example 14.2
Viewing and Creating a MongoDB Collection
```
> db.getCollectionNames("system.indexes", "user")
[ ]
> show collections
> db.getCollection("user")
datamis.user
> db.printCollectionStats();
> db.user.drop()
false
>
```

#### Example 14.3
Inserting and Querying Operations on MongoDB Documents
```
> db.student.insert({"name":"datamis","school":"beifang101",
    "numbe":21071357011})
WriteResult({ "nInserted" : 1 })
> db.student.insert({"class":101,"number":2101920,"teach":"datamis"})
WriteResult({ "nInserted" : 1 })
> db.student.find()
{ "_id" : ObjectId("6038c88ece60acab99c4b8f1"), "name" : "datamis", 
    "school" : "beifang101", "numbe" : 21071357011 }
{ "_id" : ObjectId("6038c89cce60acab99c4b8f2"), "class" : 101,
    "number" : 2101920, "teach" : "datamis" }
> db.student.find().pretty()
{
    "_id" : ObjectId("6038c88ece60acab99c4b8f1"),
    "name" : "datamis",
    "school" : "beifang101",
    "numbe" : 21071357011
}
{
    "_id" : ObjectId("6038c89cce60acab99c4b8f2"),
    "class" : 101,
    "number" : 2101920,
    "teach" : "datamis"
}
> db.student.insert({"name":"datamis","number":210246,
    "deskmate":[{"name":"daiping","number":210265},
    {"name":"dailan","number":"212064"}]})
WriteResult({ "nInserted" : 1 })
>
```

#### Example 14.4
Basic Query Operations in MongoDB
```
> // First insert some data, book names and prices //
> db.books.insert({"name":"nosql","price":27.59})
WriteResult({ "nInserted" : 1 })
> db.books.insert({"name":"mysql","price":39.97})
WriteResult({ "nInserted" : 1 })
> db.books.insert({"name":"java","price":17.80})
WriteResult({ "nInserted" : 1 })
> db.books.insert({"name":"linux","price":89.70})
WriteResult({ "nInserted" : 1 })
> db.books.insert({"name":"python","price":49.30})
WriteResult({ "nInserted" : 1 })
> db.books.insert({"name":"c++","price":57.67})
WriteResult({ "nInserted" : 1 })
> // View the data //
> db.books.find()
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f7"), "name" : "linux", "price" : 89.7 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f8"), "name" : "python", "price" : 49.38 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f9"), "name" : "c++", "price" : 57.67 }
>
> // View the data in pagination. Start from the first one and display 3 records //
>  db.books.find().skip(0).limit(3)
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
>
>  // View the data in pagination. The limit and skip functions can be interchanged, and the results are the same. //
> db.books.find().limit(3).skip(0)
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
>
>  // View the data in pagination. Equivalent to db.books.find().skip(0).limit(3) //
> db.books.find().limit(3)
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
>
>  // Skip the first 5 records and display all documents after the 6th record. //
>  db.books.find().skip(5)
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f9"), "name" : "c++", "price" : 57.67 }
>
```

#### Example 14.5
Specifying Conditional Queries in MongoDB
```
> db.books.find({"name":"nosql"})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
> db.books.find({"name":"nosql","price":27.59})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
> db.books.find({$or:[{"name":"nosql"},{"name":"java"}]})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
> db.books.find({"price":{$gte : 30}})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f7"), "name" : "linux", "price" : 89.7 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f8"), "name" : "python", "price" : 49.38 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f9"), "name" : "c++", "price" : 57.67 }
> db.books.find({"price":{$lte : 20}})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
>  db.books.find({"price":{$gte:10,$lte:35}})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 27.59 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
> db.books.find({$or:[{"price":{$gt:50}},{"price":{$lt:20}}]})
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "java", "price" : 17.8 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f7"), "name" : "linux", "price" : 89.7 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f9"), "name" : "c++", "price" : 57.67 }
> // Query the number of records in the books collection //
>db.books.find().count()
6
> // Query the first record. //
> db.books.findOne()
{
    "_id" : ObjectId("6038d9ffce60acab99c4b8f4"),
    "name" : "nosql",
    "price" : 27.59
}
>
```

#### Example 14.6
Basic Operations of Modifying and Deleting Documents in MongoDB
```
> // Modify the book name and price //
> db.books.update({"name":"java"},{$set:{"name":"javase","price":57.60}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
> // Modify the book price //
>  db.books.update({"name":"nosql"},{$set : {"price":36.9}},{multi:true})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 })
> db.books.find()
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 36.9 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f6"), "name" : "javase", "price" : 57.6 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f7"), "name" : "linux", "price" : 89.7 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f8"), "name" : "python", "price" : 49.38 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f9"), "name" : "c++", "price" : 57.67 }
> // Delete a book's data //
> db.books.remove({"name":"javase"})
WriteResult({ "nRemoved" : 1 })
> db.books.find()
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f4"), "name" : "nosql", "price" : 36.9 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f5"), "name" : "mysql", "price" : 39.97 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f7"), "name" : "linux", "price" : 89.7 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f8"), "name" : "python", "price" : 49.38 }
{ "_id" : ObjectId("6038d9ffce60acab99c4b8f9"), "name" : "c++", "price" : 57.67 }
> // Delete all data in the current collection. Use it with caution. //
> db.books.remove({})
>
```

#### Example 14.7
Basic Operations of MongoDB Indexes
```
> // Create a combined index. MongoDB will automatically create a name for the index ensureIndex. If there is one item in {}, it is a single index, and multiple items mean a combined index. 1 and -1 represent the direction of the index. //
> db.books.ensureIndex({"name":1,"price":-1})
{
    "createdCollectionAutomatically" : false,
    "numIndexesBefore" : 1,
    "numIndexesAfter" : 2,
    "ok" : 1
}
> // Create an index and specify the index name. //
> db.books.ensureIndex({"price":1},{"name":"index_price"})
{
    "createdCollectionAutomatically" : false,
    "numIndexesBefore" : 2,
    "numIndexesAfter" : 3,
    "ok" : 1
}
> // Create a unique index for name //
> db.books.ensureIndex({"name":1},{"unique":true})
{
    "createdCollectionAutomatically" : false,
    "numIndexesBefore" : 3,
    "numIndexesAfter" : 4,
    "ok" : 1
}
> // View the index information in the current collection. //
> db.books.getIndexes()
[
    {  "v" : 2,
        "key" : {"_id" : 1
                },
        "name" : "_id_"
    },
    { "v" : 2,
        "key" : {"name" : 1,
                "price" : -1
                },
        "name" : "name_1_price_-1"
    },
    { "v" : 2,
        "key" : {"price" : 1
                },
        "name" : "index_price"
    },
    { "v" : 2,
        "unique" : true,
        "key" : { "name" : 1
                },
                "name" : "name_1"
    }
]
> // Delete the index named name_1 in the books collection //
> db.books.dropIndex("name_1")
{ "nIndexesWas":4, "ok" : 1 }
> //