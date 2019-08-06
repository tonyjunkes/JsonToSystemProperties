component output=false {
	public JsonParserService function init() {
		return this;
	}

	public void function jsonToProperties( required string json ) {
		if ( isJSON( arguments.json ) ) {
			var JsonParser = createObject( "java", "com.google.gson.JsonParser" );
			var System = createObject( "java", "java.lang.System" );

			var addJson = function( root, JsonElement ) {
				// Recursion for objects
				if ( arguments.JsonElement.isJsonObject() ) {
					if ( !arguments.root.equals( "" ) ) arguments.root &= ".";
					var JsonObject = arguments.JsonElement.getAsJsonObject();
					var Iterator = JsonObject.entrySet().iterator();
					while ( Iterator.hasNext() ) {
						var element = Iterator.next();
						addJson( arguments.root & element.getKey(), element.getValue() );
					}

					return;
				}
				// Recursion for arrays
				if ( arguments.JsonElement.isJsonArray() ) {
					if ( !arguments.root.equals( "" ) ) arguments.root &= ".";
					var JsonArray = arguments.JsonElement.getAsJsonArray();
					var Iterator = JsonArray.iterator();
					var count = 1;
					while ( Iterator.hasNext() ) {
						var element = Iterator.next();
						addJson( arguments.root & count, element );
						count++;
					}

					return;
				}
				// Add property
				System.setProperty( arguments.root, arguments.JsonElement.getAsString() );
			};

			// Initial recursive entry
			var JsonElement = JsonParser.parse( arguments.json );
			addJson( "", JsonElement );
		} else {
			throw(
				message = "An error occurred while parsing the JSON into Java System Properties.",
				detail = "The string provided is not valid JSON."
			);
		}
	}
}
