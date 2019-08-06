component extends="testbox.system.BaseSpec" {

    function beforeAll() {
        variables.JsonParserService = createMock( "model.services.JsonParserService" );
		variables.System = createObject( "java", "java.lang.System" );
    };

    function run() {
        describe( "JSON Parser Service", function() {
            it( "Tests invalid JSON throws an exception", function() {
                var json = '{
                                test_key: test_value
                            }';

                expect( function() { variables.JsonParserService.jsonToProperties( json ); } )
                        .toThrow(
                            message = "An error occurred while parsing the JSON into Java System Properties.",
                            detail = "The string provided is not valid JSON."
                        );
            });

            describe( "JSON Objects", function() {
                it( "Tests loading a JSON object as a property", function() {
                    var json = '{
                                    "test_key": "test_value"
                                }';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "test_key" ) ).toBe( "test_value" );
                    variables.System.clearProperty( "test_key" );
                });

                it( "Tests loading a nested JSON object as properties", function() {
                    var json = '{
                                    "test_key": {
                                        "test_key1": "test_value1",
                                        "test_key2": "test_value2"
                                    }
                                }';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "test_key.test_key1" ) ).toBe( "test_value1" );
                    expect( variables.System.getProperty( "test_key.test_key2" ) ).toBe( "test_value2" );
                    variables.System.clearProperty( "test_key.test_key1" );
                    variables.System.clearProperty( "test_key.test_key2" );
                });
            });

            describe( "JSON Arrays", function() {
                it( "Tests loading a JSON array as properties", function() {
                    var json = '[
                                    "test_value1", "test_value2"
                                ]';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "1" ) ).toBe( "test_value1" );
                    expect( variables.System.getProperty( "2" ) ).toBe( "test_value2" );
                    variables.System.clearProperty( "1" );
                    variables.System.clearProperty( "2" );
                });

                it( "Tests loading a nested JSON array as a property", function() {
                    var json = '[
                                    [
                                        "test_value"
                                    ]
                                ]';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "1.1" ) ).toBe( "test_value" );
                    variables.System.clearProperty( "1.1" );
                });
            });

            describe( "JSON Objects & Arrays", function() {
                it( "Tests loading a nested JSON array in an object as a property", function() {
                    var json = '{
                                    "test_key": [
                                        "test_value"
                                    ]
                                }';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "test_key.1" ) ).toBe( "test_value" );
                    variables.System.clearProperty( "test_key.1" );
                });

                it( "Tests loading a nested JSON object in an array as a property", function() {
                    var json = '[
                                    {
                                        "test_key": "test_value"
                                    }
                                ]';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "1.test_key" ) ).toBe( "test_value" );
                    variables.System.clearProperty( "1.test_key" );
                });

                it( "Tests loading a JSON object with various nested elements as properties", function() {
                    var json = '{
                                    "ranger": [
                                        "Aragorn"
                                    ],
                                    "companions": {
                                        "elf": "Legolas",
                                        "others": [
                                            "Gimli",
                                            {
                                                "hobbit1": "Frodo",
                                                "hobbit2": "Sam"
                                            }
                                        ]
                                    },
                                    "home": "Gondor"
                                }';

                    variables.JsonParserService.jsonToProperties( json );
                    expect( variables.System.getProperty( "ranger.1" ) ).toBe( "Aragorn" );
                    variables.System.clearProperty( "ranger.1" );
                    expect( variables.System.getProperty( "companions.elf" ) ).toBe( "Legolas" );
                    variables.System.clearProperty( "companions.elf" );
                    expect( variables.System.getProperty( "companions.others.1" ) ).toBe( "Gimli" );
                    variables.System.clearProperty( "companions.others.1" );
                    expect( variables.System.getProperty( "companions.others.2.hobbit1" ) ).toBe( "Frodo" );
                    variables.System.clearProperty( "companions.others.2.hobbit1" );
                    expect( variables.System.getProperty( "companions.others.2.hobbit2" ) ).toBe( "Sam" );
                    variables.System.clearProperty( "companions.others.2.hobbit2" );
                    expect( variables.System.getProperty( "home" ) ).toBe( "Gondor" );
                    variables.System.clearProperty( "home" );
                });
            });
        });
    }

}