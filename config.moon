config = require "lapis.config"
import sql_password, session_secret from require "secret"

config "development", ->
    port 8080
    secret "fake"
    session_name "fake_net_dev"
    num_workers 1 --only one needed for development testing (in theory..)
    code_cache "off" --so changes are immediate
    measure_performance true --for potentially profiling and optimzing
    postgres ->
        host "127.0.0.1"
        user "postgres"
        password sql_password
        database "fake_net_dev"

config "production", ->
    port 80
    secret session_secret
    session_name "fake_net"
    num_workers 3 --designed to run on an rPi2 (4 cores, so 3 workers)
    code_cache "on"
    measure_performance false
    postgres ->
        host "127.0.0.1"
        user "postgres"
        password sql_password
        database "fake_net"
