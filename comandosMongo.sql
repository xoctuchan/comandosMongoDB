--usar una base de datos
use mi_primer_base
--Ver la base de datos seleccionada
db
--Ver las bases de datos con colecciones
show dbs

--Insertar un registro a una colección
db.movie.insert({"Doc1": "Spiderman"})


Funciones CRUD
baseDeDatos.Coleccion.FuncionCRUD
--Insertar multiples registros a una colección
insertMany()
db.movie.insertMany([{"pelicula":"Toy Story 4", "anio":"2019"}, {"pelicula":"Toy Story 3", anio:"2015"}])
	
db.movie.insertOne({"pelicula":"Hulk", "anio":"1998"})

db.movie.insert([{"pelicula":"Hulk", "anio":"1998"}])
--ordered:true : Inserta todos los registros si no hay ningun error
db.movie.insert([{"pelicula":"Toy Story 4", "anio":"2019"}, {"pelicula":"Toy Story 3", anio:"2015"}].{ordered:true})

--Listar todos los registros de una colección
db.movie.find()

--Listas los registros que cumplan con una condición
db.movie.find({"pelicula":"Toy Story 4"})

--Listas los registros que cumplen con una condición y ocultar columna _id
db.movie.find({"pelicula":"Toy Story 4"},{"_id":0})
db.movie.find({"anio": "2019"},{pelicula:1, anio:1, _id:0})

--Reemplazar un registro e insertarlo si no lo encuentra "upsert:true"
db.movie.replaceOne({"pelicula":"Toy Story 2"}, {"pelicula":"Toy Story 4","anio":"2019"}, {upsert:true})

--Actualizar un registro y/o varios registros que cumplan con la condición "multi:true"
db.movie.updateOne({"pelicula":"Toy Story 4"},{$set: {"anio":"2019", "descripcion":"Prueba de actualización de registro"}},{multi:true})

--Cuenta los registros de una colección
db.movie.find().count()

--Limite de registros a mostrar
db.movie.find().limit(2)

--Muestra el registro en la posición 0 de la consulta
db.movie.find()[0]


--Insertar registro a una colección con un documento dentro de una columna
db.prueba.insertMany([{"item":"journal", "stock":[{"warehouse":"A", "qty":"10"},{"warehouse":"B", "qty":"3"}]}])

--Buscar registros con una o varias condiciones dentro de los documentos incrustados
db.prueba.find({"stock.warehouse":"A"})

--Buscar registros con una o varias condiciones dentro de los documentos incrustados que este en la primera posición
db.prueba.find({"stock.0.warehouse":"A"})


--Elimina todas las colecciones
db.prueba.drop()

--Elimina la base de datos
db.dropDatabase()

--Busca registros en donde el tipo de datos insertado en la columna anio sea de tipo string
db.movie.find({"anio":{$type: "string"}})



db.patron.findOne({name:"Joe Book"})._id

mongoimport --help
--Importar archivo csv a mongo
mongoimport --d proyecto1 --collection prueba --type csv --headerline --file c:\RutaDelArchivo.csv



--Operadores que ofrece mongoDB
https://www.mongodb.com/docs/manual/reference/operator/query/

--$eq "=="
db.movie.find({"pelicula":{$eq:"Hulk"}})

--$gt ">"
db.movie.find({anio:{$gt:2000}})

--$gte ">="
db.movie.find({"no_cdtos":{$gte:100}})

--$lt "<"
db.movie.find({"no_cdtos":{$lt:100}})

--$lte "<="
db.movie.find({"no_cdtos":{$lte:100}})

--$in "in()"
db.movie.find({"pelicula":{$in:["Toy Story 4","Toy Story 3"]}})

--$nin "nin()"
db.movie.find({"pelicula":{$nin:["Toy Story 4","Toy Story 3"]}})


--$and "and"
db.movie.find({$and : [{"pelicula":"Toy Story 4"}, {"anio":{$gte:"2019"}}]})

--$or "or"
db.movie.find({$or : [{"pelicula":"Toy Story 4"}, {"anio":{$gte:"2000"}}]})

--$not (not) registros con precio no sean mayores a 1.99
db.inventory.find( { price: { $not: { $gt: 1.99 } } } )

--$nor cuando el precio no sea == 1.99 y sale==true
db.inventory.find( { $nor: [ { price: 1.99 }, { sale: true } ]  } )

--$exists verifica si el campo existe
db.inventory.find( { qty: { $exists: true, $nin: [ 5, 15 ] } } )

--$type busca los registros en donde el campo es del tipo buscado
db.addressBook.find( { "zipCode" : { $type : "string" } } );

--$regex es como el like 
db.products.find( { sku: { $regex: /789$/ } } )

db.monthlyBudget.find( { $expr: { $gt: [ "$spent" , "$budget" ] } } )

--$size Hace consulta sobre una matriz
db.movie.find({actores:{$size:4}})

--$all  - Tienen que coincidir todos los valores en la matriz
db.movie.find({actores:{$all:["Martin", "Laura"]}})

--$selemMatch   busca que se cumplan las condicionales dentro de un documento incrustado
db.movie.find({actores:{$selemMatch:["edad":{$gt:50, $lte:30}}})

-- Guardar los registros de la consulta en una constante
const Cursor = db.movie.find()
Cursor.next()
Cursor.hasNext()

--Ordenamiento de los registros por columna 1:Ascendente -1: Descendente 
db.movie.find().sort({"anio":1})

-- Ordenamiento prioridad por columna anio, pelicula
db.movie.find().sort({"anio":1, "Pelicula":1})

-- Limitar los registros a mostrar
db.movie.find().sort({"anio":1}).limit(5)

-- Saltar los primeros 5 registros y despues solo mostrar 1
db.movie.find().sort({"anio":1}).skip(5).limit(1)

-- Campos que vamos a mostrar 1:mostrar, 0:no mostrar
db.movie.find({},{"pelicula":1, "_id":0})

-- Muestra la columna actores y unicamente el valor buscado
db.movie.find({actores:"Martin"},{"actores.$":1})

--$slice Muestra los primeros n elementos de una matriz
db.movie.find({},{"actores":{$slice:2}})

db.movie.find({},{"actores":{$slice:[0,3]}})

--UpdateOne
db.movie.updateOne({"pelicula":"Toy Story 4"},{$set: {"anio":"2019", "descripcion":"Prueba de actualización de registro"}},{multi:true})
db.movie.updateOne({"pelicula":"Toy Story 4"},{$set: {"anio":2019}})

--updateMany
db.movie.updateMany({"pelicula":"Toy Story 4"},{$set: {"anio":"2019", "descripcion":"Prueba de actualización de registro"}},{multi:true})



--$inc  Incrementar en n el valor de una columna
db.movie.updateOne({"pelicula":"Hulk"},{$inc:{"anio":1}})

--min Actualiza el valor de una columna si el valor es menor al que ya tiene.
db.movie.updateOne({"pelicula":"Hulk"},{$min:{"anio":1995}})


--max Actualiza el valor de una columna si el valor es mayor al que ya tiene.
db.movie.updateOne({"pelicula":"Hulk"},{$max:{"anio":1995}})

--$mul  multiplica el valor de una columna por n cantidad
db.movie.updateOne({"pelicula":"Hulk"},{$mul:{"anio":2}})

--$unset Elimina el campo de un registro
db.movie.updateOne({"pelicula":"Toy Story 4"},{$unset: {"descripcion":""}})

--$rename Actualiza el nombre de un campo
db.movie.updateOne({"pelicula":"Toy Story 4"},{$rename: {"anios":"anio"}})

--$upsert Actualiza el nombre de un campo
db.movie.updateOne({"pelicula":"Toy Story 2"},{$set: {"anio":2010}},{upsert:true})

--$deleteOne() Elimina el primer registro que coincida con la condición
db.movie.deleteOne({"pelicula":"Hulk"})

--$deleteMany Elimina todos los registros que coincidan con la condición
db.movie.deleteMany({"pelicula":"Hulk"})

-- Eliminar colección
db.movie.drop()

--Eliminar la base de datos
db.dropDatabase()

--$match es como el metodo find(), 
--$group es como el groupBy, 
--$sort ordernar por columna, 
--$project se agregan las columnas que se quieren mostrar, 
--$concat es para concatenar el valor de los campos

db.prueba.aggregate ([
{$match:{"no_cdtos":{$gte:352}}},
{$group:{_id:{id_sucursal:"$id_sucursal"}, clientes_adeudo:{$sum:"$no_clientes"}}},
{$sort: {"clientes_adeudo":-1}},
{$project: {cliente_adeudo:1, campo_nuevo:{$concat: ["Este es un campo"," nuevo"]}}}
])

https://www.mongodb.com/docs/manual/core/aggregation-pipeline/


MongoDB: Aprende desde cero a experto
UC-f17ab45f-d10d-40e6-87b2-1390762f190f
https://ude.my/UC-f17ab45f-d10d-40e6-87b2-1390762f190f/