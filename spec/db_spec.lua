require 'luaspec'
require 'luamock'

local db = require 'couchdb.db'

describe["database api"] = function()
	describe["retrieving all databases"] = function()
		before = function()
			server = "server:5984"
			
			mock(couchdb.helpers, "run_request")
			
			databases = db.all(server)
		end
		
		it["should do a GET request to http://server/_all_dbs"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/_all_dbs", "GET")
		end
	end

	describe["creating a database"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			
			mock(couchdb.helpers, "run_request")
			
			databases = db.create(server, database)
		end
		
		it["should do a PUT request to http://server/databasename/"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/", "PUT")
		end
	end

	describe["deleting a database"] = function()
		before = function()
			server = "server:5984"
			database = "somedatabase"
			
			mock(couchdb.helpers, "run_request")
			
			databases = db.delete(server, database)
		end
		
		it["should do a DELETE request to http://server/databasename/"] = function()
			expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/", "DELETE")
		end

		describe["getting information about a database"] = function()
			before = function()
				server = "server:5984"
				database = "somedatabase"

				mock(couchdb.helpers, "run_request")

				databases = db.info(server, database)
			end

			it["should do a GET request to http://server/databasename/"] = function()
				expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/", "GET")
			end
			
			describe["compacting a database"] = function()
				before = function()
					server = "server:5984"
					database = "somedatabase"

					mock(couchdb.helpers, "run_request")

					databases = db.compact(server, database)
				end

				it["should do a POST request to http://server/databasename/_compact"] = function()
					expect(couchdb.helpers.run_request).was_called_with("http://server:5984/somedatabase/_compact", "POST")
				end
			end
		end
	end	
end
