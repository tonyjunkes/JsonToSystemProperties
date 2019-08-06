
# JSON to System Properties [![Build Status](https://travis-ci.org/tonyjunkes/jsontosystemproperties.svg?branch=master)](https://travis-ci.org/tonyjunkes/jsontosystemproperties)

A CFC for turning valid JSON elements into Java System Properties with GSON.

## Requirements

* Lucee 5.x+ or Adobe ColdFusion 2016+
* Google GSON 2.8.5

## Installation

### CommandBox

Installation via ForgeBox/CommandBox coming soon...

### Manual

TODO

## Usage

TODO

## Development

### Running Tests With CommandBox & TestBox

From the project root, start CommandBox in your preferred terminal and point to the `/test-harness` directory (`cd test-harness`). Include the test dependencies (TestBox) by running `install`. Start the server by executing `server start`. The server instance will be located at `http://127.0.0.1:8520`.

> Note: By default, the test harness server will use Lucee 5. To use a specific engine/version, either update the `server.json` or run `server start cfengine=[engine]@[version]`.

Once the server has started, you can run `testbox run` in the terminal to execute the tests. To view the test results in the browser, you can navigate to `http://127.0.0.1:8520/tests/runner.cfm`.
