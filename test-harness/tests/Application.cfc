component {
    this.name = "JsonToSystemPropertiesTestingSuite" & hash(getCurrentTemplatePath());
    variables.testsPath = getDirectoryFromPath( getCurrentTemplatePath() );
    this.mappings = {
        "/tests": variables.testsPath,
        "/testbox": variables.testsPath & "../testbox",
        "/model": variables.testsPath & "../../model",
        "/lib": variables.testsPath & "../../lib"
    };
	this.javaSettings.loadPaths = ["/lib/gson-2.8.5"];
}