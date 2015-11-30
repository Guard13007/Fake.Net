# Fake.Net

Fake.Net is a fake internet all in one server.

Why? Because my school was making a LAN of Raspberry Pi's and I thought it
would be entertaining to set up a fake internet.

## Progress

- Tweaker (Twitter): 10%
- Nothing else yet!

## Install (to Run)

(see Install (to Dev) below if you want to develop Fake.Net)

1. Install Lua 5.1
   Note: There needs to be a Lua executable named `lua` or LuaRocks will fail to recognize it.
2. Install [OpenResty](https://openresty.org/)
3. Install LuaRocks
   ```bash
   wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
   #or a newer version!
   tar zxpf luarocks-2.2.2.tar.gz
   cd luarocks-2.2.2/
   ./configure --lua-version=5.1
   #if it complains about unable to find lua, you may need to use --with-lua=/path/to
   # or --with-lua-bin=/path/to/lua
   sudo make bootstrap
   ```
4. Install Lapis
   Using LuaRocks: `sudo luarocks install lapis`

(This script is written assuming you are a sudoer and using apt-get:)

```bash
# Lua
sudo apt-get install lua5.1
#verify that it exists, and is named 'lua'! if not, you need to make it accessible that way *somewhere*

# OpenResty
wget (OPENRESTY DL URL)
tar xzvf ngx_openresty-VERSION.tar.gz
cd ngx_openresty-VERSION/
./configure
make
sudo make install
cd ..

# LuaRocks
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
#or a newer version!
tar zxpf luarocks-2.2.2.tar.gz
cd luarocks-2.2.2/
./configure --lua-version=5.1
#if it complains about unable to find lua, you may need to use --with-lua=/path/to
# or --with-lua-bin=/path/to/lua
sudo make bootstrap

# Lapis
sudo luarocks install lapis
```

## Install (to Run)

(see Install (to Dev) below if you want to develop Fake.Net)

1. Install Lua 5.1
   Note: There needs to be a Lua executable named `lua` or LuaRocks will fail to recognize it.
2. Install [OpenResty](https://openresty.org/)
3. Install LuaRocks
   ```bash
   wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
   #or a newer version!
   tar zxpf luarocks-2.2.2.tar.gz
   cd luarocks-2.2.2/
   ./configure --lua-version=5.1
   #if it complains about unable to find lua, you may need to use --with-lua=/path/to
   # or --with-lua-bin=/path/to/lua
   sudo make bootstrap
   ```
4. Install Lapis & Moonscript & Lapis Console
   Using LuaRocks:
   ```bash
   sudo luarocks install lapis
   sudo luarocks install moonscript
   sudo luarocks install lapis-console
   ```

(This script is written assuming you are a sudoer and using apt-get:)

```bash
# Lua
sudo apt-get install lua5.1
#verify that it exists, and is named 'lua'! if not, you need to make it accessible that way *somewhere*

# OpenResty
wget (OPENRESTY DL URL)
tar xzvf ngx_openresty-VERSION.tar.gz
cd ngx_openresty-VERSION/
./configure
make
sudo make install
cd ..

# LuaRocks
wget http://luarocks.org/releases/luarocks-2.2.2.tar.gz
#or a newer version!
tar zxpf luarocks-2.2.2.tar.gz
cd luarocks-2.2.2/
./configure --lua-version=5.1
#if it complains about unable to find lua, you may need to use --with-lua=/path/to
# or --with-lua-bin=/path/to/lua
sudo make bootstrap

# Lapis & Moonscript & Lapis Console
sudo luarocks install lapis
sudo luarocks install moonscript
sudo luarocks install lapis-console
```

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
