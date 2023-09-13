#!/bin/sh
/RESTler/restler/Restler compile --api_spec /mnt/shared/${OPEN_API_FILE}
/RESTler/restler/Restler test --grammar_file ./Compile/grammar.py --dictionary_file ./Compile/dict.json --settings ./Compile/engine_settings.json --target_ip ${SERVER:="host.docker.internal"} --target_port ${PORT} --no_ssl
/RESTler/restler/Restler fuzz --grammar_file ./Compile/grammar.py --dictionary_file ./Compile/dict.json --settings ./Compile/engine_settings.json --time_budget ${TIME_BUDGET} --target_ip ${SERVER:="host.docker.internal"} --target_port ${PORT} --no_ssl