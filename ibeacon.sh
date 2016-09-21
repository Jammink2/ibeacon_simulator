#!/bin/bash
td table:delete ibeacon_test events
td db:delete ibeacon_test
ruby ibeacon_simulator.rb "<TD_WRITE_ONLY_API_KEY>" 500
