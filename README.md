# Fake.Net

Fake.Net is a fake internet all in one server.

Why? Because my school was making a LAN of Raspberry Pi's and I thought it
would be entertaining to set up a fake internet.

## Notes

1. Fuck Linux's permissions system. I can't run on port 80 without being root,
   but root CAN'T ACCESS MY FILES?
2. Fuck Font Awesome. It worked wonderfully when I used it with SkillTrack.
   Here? Doesn't work at all. I've gone through every troubleshooting step I
   could find, and nothing fixes it.
3. Why did nothing about OpenResty or LuaRocks or Lapis EVER say I needed to
   make sure I was working with Lua 5.1? Seriously, what the fuck. Hours
   wasted for no good reason.
4. DON'T LIE ABOUT IPTABLES YOU DICK.

## Setup Fake.Net

These instructions are for setting up Fake.Net for development
... or for just running it.

1. Install Lua 5.1
   Make sure there is a "lua" executable accessible (either in `PATH` or
   manually specified by `--with-lua=/path/to`)
2. Install OpenResty
   1. Download: https://openresty.org/#Download
   2. tar xzvf openresty-VERSION.tar.gz
   3. cd openresty-VERSION/
   4. ./configure
   5. make
   6. make install
3. Install `luarocks`
   1. wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
      (or latest version)
   2. tar zxpf luarocks-2.2.2.tar.gz
   3. cd luarocks-2.2.2/
   4. ./configure --lua-version=5.1
      (or manually specify path to "lua" executable by `--with-lua=/path/to`)
   5. sudo make bootstrap
4. Install Lapis & Moonscript
   1. sudo luarocks install lapis
   2. sudo luarocks install moonscript
5. Install / Setup PostgreSQL
   1. Install via your package manager (or whatever, as long as it works)
   2. Change postgres user password
      `sudo passwd postgres`
      (Note: Keep this password for later! You will need it.)
   3. Switch to postgres user
      `sudo -i -u postgres`
   4. Initialize database cluster
      `initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'`
   5. Start PostgreSQL (will need to be running for your server to work!)
      `postgres -D '/var/lib/postgres/data'`
   6. Create Fake.Net database (from another terminal, as PostgreSQL is now
      running in the first)
      `createdb fake_net`
      (if developing, also make a development database called fake_net_dev)
6. Start moonc watching for changes and recompiling:
   `moonc -w .`
   Note that this will only watch for changes to .moon files already existing.
   To compile new source files, you will need to restart this.
6. Start Lapis
   1. Navigate to where you cloned the repository.
   2. Copy `secret.moon.example` to `secret.moon` and use the password you
      set up for PostgreSQL.
      (You also probably want to set the session secret to something random.)
   3. Start Lapis with `sudo lapis server production`
      (unless you are developing, in which case, use `lapis server development`)
      * Note, there are stupid permission errors I still have to work out
        because FUCK ME IF I WANT TO DO SOMETHING EVEN SLIGHTLY NOT THE WAY
        LINUX DEMANDS THINGS BE DONE &gt;.&lt;
7. To get the server accessible from port 80:
   `iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 1080`
   Excuse me, never mind, I was lied to. FUCK ALL OF YOU.

## Running Fake.Net

TODO: Write this section about how to set it up for automatic
      running / un-attended running. Non-development.
