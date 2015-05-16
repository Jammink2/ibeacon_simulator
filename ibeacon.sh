#!/bin/bash
td table:delete ibeacon_test events
td db:delete ibeacon_test
ruby ibeacon_simulator.rb "5919/d185d619713940e5f76a6205539af8e2b6c4d3bc" 500
