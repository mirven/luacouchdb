require 'luaspec'

local helpers = require 'couchdb.helpers'

describe["helper to stringify get parameters"] = function()
	describe["nil params"] = function()
		before = function()
			params_string = helpers.stringify_params(nil)
		end
		
		it["should return an empty string"] = function()
			expect(params_string).should_be("")
		end
	end

	describe["empty params"] = function()
		before = function()
			params_string = helpers.stringify_params {}
		end
		
		it["should return an empty string"] = function()
			expect(params_string).should_be("")
		end
	end
	
	describe["a single parameter"] = function()
		before = function()
 			params_string = helpers.stringify_params { name = "value" }
		end
		
		it["should return an empty string"] = function()
			expect(params_string).should_be("?name=value")
		end
	end
	
	describe["multiple parameters"] = function()
		before = function()
 			params_string = helpers.stringify_params { name1 = "value1", name2 = "value2" }
		end
		
		it["should return an empty string"] = function()
			expect(params_string).should_be("?name2=value2&name1=value1")
		end
	end
end

describe["url helper"] = function()
	describe["providing server, database, and path"] = function()
		before = function()
			server = "server:5984"
			database = "database"
			path = "path"
			
			url = helpers.url(server, database, path)
		end
		
		it["should return a url in the form of http://server/database/path"] = function()
			expect(url).should_be("http://server:5984/database/path")
		end
	end
	
	describe["providing server and database"] = function()
		before = function()
			server = "server:5984"
			database = "database"
			
			url = helpers.url(server, database)
		end
		
		it["should return a url in the form of http://server/database/"] = function()
			expect(url).should_be("http://server:5984/database/")
		end
	end
	
	describe["providing server and path"] = function()
		before = function()
			server = "server:5984"
			path = "path"
			
			url = helpers.url(server, nil, path)
		end
		
		it["should return a url in the form of http://server/path"] = function()
			expect(url).should_be("http://server:5984/path")
		end
	end
	
	describe["providing only server"] = function()
		before = function()
			server = "server:5984"
			
			url = helpers.url(server)
		end
		
		it["should return a url in the form of http://server/"] = function()
			expect(url).should_be("http://server:5984/")
		end
	end
end
