require 'luaspec'
require 'luamock'

local doc = require 'couchdb.doc'

describe["document api"] = function()
	describe["reading all documents"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
		
			mock(couchdb.helpers, "run_request")
		
			documents = doc.all(server, database)
		end
	
		it["should do a GET request to http://server/databasename/_all_docs"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/_all_docs", "GET")
		end
	end

	describe["creating a document without specifying an id"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			
			mock(couchdb.helpers, "run_request")
			
			info = doc.create(server, database, { key = "value" })
		end
		
		it["should do a POST request to http://server/databasename/ with a json encoded body"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/", "POST", '{"key":"value"}')
		end
	end
	
	describe["creating a document while specifying an id"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			document_id = "someid"
			
			mock(couchdb.helpers, "run_request")
			
			info = doc.create(server, database, { key = "value" }, document_id)
		end
		
		it["should do a PUT request to http://server/databasename/docid with a json encoded body"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/someid", "PUT", '{"key":"value"}')
		end		
	end
	
	describe["reading a document by its id"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			document_id = "someid"

			mock(couchdb.helpers, "run_request")
			
			info = doc.get(server, database, document_id)		
		end
		
		it["should do a GET request to http://server/database/docid"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/someid", "GET")
		end
	end

	describe["reading a document by its id and specifying a revision"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			document_id = "someid"
			rev = "10"

			mock(couchdb.helpers, "run_request")
			
			info = doc.get(server, database, document_id, rev)		
		end
		
		it["should do a GET request to http://server/database/docid?rev=revid"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/someid?rev=10", "GET")
		end
	end
	
	describe["deleting a document"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			document_id = "someid"
			rev = "10"

			mock(couchdb.helpers, "run_request")
			
			info = doc.delete(server, database, document_id, rev)		
		end
		
		it["should do a DELETE request to http://server/database/docid?rev=revid"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/someid?rev=10", "DELETE")
		end
	end
end
